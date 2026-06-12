//
//  CommsView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 3/11/2023.
//

import Apollo
import NukeUI
import PrivateUploaderAPI
import SDWebImageSwiftUI
import SwiftUI
import UserNotifications

struct CommsView: View {
  enum FocusedField {
    case editing, sending
  }

  @EnvironmentObject var store: Store
  @EnvironmentObject var showingUserStore: ShowingUserStore
  @FocusState private var focusedField: FocusedField?
  @State private var chatsList: [ChatsQuery.Data.Chat] = []
  @State private var chatOpen: Int = -1
  @State private var unreadId: Int = -1
  @State private var editingId: Int = -1
  @State private var replyingId: Int = -1
  @State private var inputMessage: String = ""
  @State private var editingMessage: String = ""
  @State private var messagesSubscription: Apollo.Cancellable?
  @State private var notifications: Int = 0
  @State private var showUsers: Bool = true
  @State private var typingEvents: [OnTypingSubscription.Data.OnTyping] = []

  private var chatUsers: [StateQuery.Data.TrackedUser] {
    guard let association = chatsList.first(where: { $0.association?.id == chatOpen }),
          let coreUsers = store.coreUsers
    else { return [] }

    return association.users.compactMap { member in
      coreUsers.first { $0.id == member.user?.id }
    }
  }

  private var onlineUsers: [StateQuery.Data.TrackedUser] {
    chatUsers.filter { $0.status.value != .offline }
  }

  private var offlineUsers: [StateQuery.Data.TrackedUser] {
    chatUsers.filter { $0.status.value == .offline }
  }

  func getChats() {
    Network.shared.apollo.fetch(query: ChatsQuery(), cachePolicy: .returnCacheDataAndFetch) { result in
      switch result {
      case let .success(graphQLResult):
        if let unwrapped = graphQLResult.data {
          chatsList = unwrapped.chats
        }
      case let .failure(error):
        print("Failure! Error: \(error)")
      }
    }
  }

  func newToChat(chatObject: ChatsQuery.Data.Chat, self: Bool) -> ChatsQuery.Data.Chat {
    var chatData = DataDict(data: [:], fulfilledFragments: Set<ObjectIdentifier>())

    chatData["id"] = chatObject.id
    chatData["type"] = chatObject.type
    chatData["name"] = chatObject.name
    chatData["unread"] = self ? (chatObject.unread ?? 0) + 1 : chatObject.unread
    chatData["icon"] = chatObject.icon
    chatData["association"] = chatObject.association
    chatData["users"] = chatObject.users
    chatData["sortDate"] = String(Date().timeIntervalSince1970 * 1000)
    chatData["recipient"] = chatObject.recipient

    return ChatsQuery.Data.Chat(_dataDict: chatData)
  }

  func scheduleNotification(title: String, body: String, to: Int) {
    notifications += 1
    UNUserNotificationCenter.current().setBadgeCount(notifications)
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default
    content.userInfo = ["to": to]

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
    UNUserNotificationCenter.current().add(request) { error in
      if let error {
        print("Error scheduling notification: \(error)")
      }
    }
  }

  func tryMessagesSubscription() {
    if messagesSubscription == nil {
      messagesSubscription = Network.shared.apollo.subscribe(subscription: UpdateMessagesSubscription()) { result in
        switch result {
        case let .success(graphQLResult):
          if let message = graphQLResult.data?.onMessage.message {
            let index = chatsList.firstIndex(where: { $0.id == message.chatId })
            let newChat = newToChat(chatObject: chatsList[index ?? 0], self: store.coreUser?.id != message.userId)
            chatsList[index ?? 0] = newChat

            chatsList.sort {
              Double($0.sortDate ?? "0") ?? 0 > Double($1.sortDate ?? "0") ?? 0
            }

            #if os(macOS)
              if !NSApplication.shared.isActive, store.coreUser?.id != message.userId {
                scheduleNotification(title: message.user?.username ?? "Unknown User", body: message.content ?? "Unknown Message", to: message.chatId)
              }
            #endif
          }
        case let .failure(error):
          print("Failed to subscribe \(error)")
        }
      }
    }
  }

  func tryTypingSubscription() {
    _ = Network.shared.apollo.subscribe(subscription: OnTypingSubscription()) { result in
      switch result {
      case let .success(graphQLResult):
        guard let message = graphQLResult.data?.onTyping else {
          return
        }

        Task {
          let expiresAt =
            TimeInterval(message.expires ?? 0) / 1000

          let delay =
            expiresAt - Date().timeIntervalSince1970

          if delay < 0 {
            return
          }

          typingEvents.removeAll {
            $0.user.username == message.user.username &&
              $0.chatId == message.chatId
          }

          typingEvents.append(message)

          try? await Task.sleep(
            for: .seconds(delay)
          )

          typingEvents.removeAll {
            $0.user.username == message.user.username &&
              $0.chatId == message.chatId &&
              $0.expires == message.expires
          }
        }
      case let .failure(error):
        print("Failed to subscribe \(error)")
      }
    }
  }

  func tryCancelTypingSubscription() {
    _ = Network.shared.apollo.subscribe(subscription: OnCancelTypingSubscription()) { result in
      switch result {
      case let .success(graphQLResult):
        guard let message = graphQLResult.data?.onCancelTyping else {
          return
        }

        Task {
          typingEvents.removeAll {
            $0.user.username == message.user.username &&
              $0.chatId == message.chatId
          }
        }
      case let .failure(error):
        print("Failed to subscribe \(error)")
      }
    }
  }

  func getStatusColor(_ status: PrivateUploaderAPI.UserStatus) -> Color {
    switch status {
    case .offline: .gray
    case .online: .green
    case .busy: .red
    default: .yellow
    }
  }

  var body: some View {
    #if os(macOS)
      HStack {
        List {
          ForEach(0 ..< chatsList.count, id: \.self) { result in
            Button(action: { chatOpen = chatsList[result].association?.id ?? -1 }) {
              HStack {
                if let recipient = chatsList[result].recipient {
                  ProfileStatus(avatar: recipient.avatar, status: store.coreUsers?.first { $0.id == recipient.id }?.status.value ?? .offline, isTyping: typingEvents.contains(where: { $0.user.username == chatsList[result].recipient?.username && $0.chatId == chatsList[result].id }))
                } else {
                  ProfilePicture(avatar: chatsList[result].icon, placeholder: "person.3.fill")
                }

                Text(chatsList[result].recipient?.username ?? chatsList[result].name).lineLimit(1)
                Spacer()
                if chatsList[result].unread != 0 {
                  Text(String(chatsList[result].unread!))
                    .frame(minWidth: 16, minHeight: 16)
                    .background(Color.red)
                    .cornerRadius(10)
                }
              }.contentShape(Rectangle())
            }.padding(4).buttonStyle(.plain).background(RoundedRectangle(cornerRadius: 8)
              .fill(chatsList[result].association?.id == chatOpen ? Color(.tertiarySystemFill) : Color.clear))
              .contextMenu {
                if let recipient = chatsList[result].recipient {
                  Button {
                    showingUserStore.shownUser = store.coreUsers?.first { $0.id == recipient.id }
                    showingUserStore.isShowingUser = true
                  } label: {
                    Label("Show Profile", systemImage: "person")
                  }
                }

                Button {
                  copyToClipboard(String(chatsList[result].association?.id ?? chatsList[result].id))
                } label: {
                  Label("Copy Chat ID", systemImage: "person.text.rectangle")
                }
              }
          }
        }
        .frame(width: 160)
        .padding(EdgeInsets(top: -8, leading: -10, bottom: -8, trailing: 0))
        if chatOpen != -1 {
          ChatView(chatsList: $chatsList, chatOpen: $chatOpen)
            .inspector(isPresented: $showUsers) {
              List {
                let chatId: Int = chatsList.first { $0.association?.id == chatOpen }?.id ?? -1
                if !onlineUsers.isEmpty {
                  Section("Online") {
                    ForEach(onlineUsers, id: \.id) { user in
                      UserRow(user: user, isTyping: typingEvents.contains(where: { $0.user.username == user.username && $0.chatId == chatId }))
                    }
                  }
                }

                if !offlineUsers.isEmpty {
                  Section("Offline") {
                    ForEach(offlineUsers, id: \.id) { user in
                      UserRow(user: user, isOffline: true, isTyping: typingEvents.contains(where: { $0.user.username == user.username && $0.chatId == chatId }))
                    }
                  }
                }
              }.scrollContentBackground(.hidden).inspectorColumnWidth(min: 160, ideal: 160, max: 220)
            }
            .toolbar {
              Toggle(isOn: $showUsers) {
                Label("Users", systemImage: "person.2.fill")
              }.help("Users list")
            }
        } else {
          VStack {
            Spacer()
            HStack {
              Spacer()
              Text("Comms")
              Spacer()
            }
            Spacer()
          }
        }
      }
      .navigationTitle("Comms")
      .onAppear {
        getChats()
        tryMessagesSubscription()
        tryTypingSubscription()
        tryCancelTypingSubscription()
      }
      .onDisappear {
        if let subscription = messagesSubscription {
          subscription.cancel()
          messagesSubscription = nil
        }
      }
      .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("NavigateToPage"))) { notification in
        if let userInfo = notification.userInfo, let pageID = userInfo["to"] as? Int {
          chatOpen = chatsList.first(where: { $0.id == pageID })?.association?.id ?? -1
        }
      }
    #else
      NavigationStack {
        if chatsList.isEmpty {
          VStack {
            Spacer()
            Text("No chats")
              .foregroundColor(.secondary)
              .font(.headline)
            Spacer()
          }
        } else {
          List {
            ForEach(0 ..< chatsList.count, id: \.self) { result in
              NavigationLink(destination: ChatView(chatsList: $chatsList, chatOpen: .constant(chatsList[result].association?.id ?? -1)).toolbar(.hidden, for: .tabBar)) {
                HStack {
                  if let recipient = chatsList[result].recipient {
                    ProfileStatus(avatar: recipient.avatar, status: store.coreUsers?.first { $0.id == recipient.id }?.status.value ?? .offline, isTyping: typingEvents.contains(where: { $0.user.username == chatsList[result].recipient?.username && $0.chatId == chatsList[result].id }))
                  } else {
                    ProfilePicture(avatar: chatsList[result].icon, placeholder: "person.3.fill")
                  }

                  Text(chatsList[result].recipient?.username ?? chatsList[result].name).lineLimit(1)
                  Spacer()
                  if chatsList[result].unread != 0 {
                    Text(String(chatsList[result].unread!))
                      .frame(minWidth: 16, minHeight: 16)
                      .background(Color.red)
                      .cornerRadius(10)
                  }
                }.contentShape(Rectangle())
              }.buttonStyle(.plain)
                .contextMenu {
                  Button {
                    copyToClipboard(String(chatsList[result].association?.id ?? chatsList[result].id))
                  } label: {
                    Label("Copy Chat ID", systemImage: "person.text.rectangle")
                  }
                }
            }
          }
        }
      }
      .onAppear {
        getChats()
        tryMessagesSubscription()
        tryTypingSubscription()
        tryCancelTypingSubscription()
      }
      .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("NavigateToPage"))) { notification in
        if let userInfo = notification.userInfo, let pageID = userInfo["to"] as? Int {
          chatOpen = chatsList.first(where: { $0.id == pageID })?.association?.id ?? -1
        }
      }
    #endif
  }
}
