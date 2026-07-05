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
  @EnvironmentObject var chatsListStore: ChatsListStore
  @FocusState private var focusedField: FocusedField?
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
    guard let association = chatsListStore.chats.first(where: { $0.association?.id == chatOpen }),
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
            guard let index = chatsListStore.chats.firstIndex(where: { $0.id == message.chatId }) else {
              return
            }

            var chats = chatsListStore.chats

            chats[index] = newToChat(chatObject: chats[index], self: store.coreUser?.id != message.userId)

            let unreadCount = chatsListStore.chats.reduce(0) { total, chat in
              total + (chat.unread ?? 0)
            }

            chats.sort {
              Double($0.sortDate ?? "0") ?? 0 > Double($1.sortDate ?? "0") ?? 0
            }

            chatsListStore.chats = chats
            chatsListStore.unreadCount = unreadCount

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
          ForEach(0 ..< chatsListStore.chats.count, id: \.self) { result in
            Button(action: { chatOpen = chatsListStore.chats[result].association?.id ?? -1 }) {
              HStack {
                if let recipient = chatsListStore.chats[result].recipient {
                  ProfileStatus(avatar: recipient.avatar, status: store.coreUsers?.first { $0.id == recipient.id }?.status.value ?? .offline, isTyping: typingEvents.contains(where: { $0.user.username == chatsListStore.chats[result].recipient?.username && $0.chatId == chatsListStore.chats[result].id }))
                } else {
                  ProfilePicture(avatar: chatsListStore.chats[result].icon, placeholder: "person.3.fill")
                }

                Text(chatsListStore.chats[result].recipient?.username ?? chatsListStore.chats[result].name).lineLimit(1)
                Spacer()
                if chatsListStore.chats[result].unread != 0 {
                  Text(String(chatsListStore.chats[result].unread!))
                    .frame(minWidth: 16, minHeight: 16)
                    .background(Color.red)
                    .cornerRadius(10)
                }
              }.contentShape(Rectangle())
            }.padding(4).buttonStyle(.plain).background(RoundedRectangle(cornerRadius: 8)
              .fill(chatsListStore.chats[result].association?.id == chatOpen ? Color(.tertiarySystemFill) : Color.clear))
              .contextMenu {
                if let recipient = chatsListStore.chats[result].recipient {
                  Button {
                    showingUserStore.shownUser = store.coreUsers?.first { $0.id == recipient.id }
                    showingUserStore.isShowingUser = true
                  } label: {
                    Label("Show Profile", systemImage: "person")
                  }
                }

                Button {
                  copyToClipboard(String(chatsListStore.chats[result].association?.id ?? chatsListStore.chats[result].id))
                } label: {
                  Label("Copy Chat ID", systemImage: "person.text.rectangle")
                }
              }
          }
        }
        .frame(width: 160)
        .padding(EdgeInsets(top: -8, leading: -10, bottom: -8, trailing: 0))
        if chatOpen != -1 {
          ChatView(chatsList: $chatsListStore.chats, chatOpen: $chatOpen)
            .inspector(isPresented: $showUsers) {
              List {
                let chatId: Int = chatsListStore.chats.first { $0.association?.id == chatOpen }?.id ?? -1
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
          chatOpen = chatsListStore.chats.first(where: { $0.id == pageID })?.association?.id ?? -1
        }
      }
    #else
      NavigationStack {
        if chatsListStore.chats.isEmpty {
          VStack {
            Spacer()
            Text("No chats")
              .foregroundColor(.secondary)
              .font(.headline)
            Spacer()
          }
        } else {
          List {
            ForEach(0 ..< chatsListStore.chats.count, id: \.self) { result in
              NavigationLink(destination: ChatView(chatsList: $chatsListStore.chats, chatOpen: .constant(chatsListStore.chats[result].association?.id ?? -1)).toolbar(.hidden, for: .tabBar)) {
                HStack {
                  if let recipient = chatsListStore.chats[result].recipient {
                    ProfileStatus(avatar: recipient.avatar, status: store.coreUsers?.first { $0.id == recipient.id }?.status.value ?? .offline, isTyping: typingEvents.contains(where: { $0.user.username == chatsListStore.chats[result].recipient?.username && $0.chatId == chatsListStore.chats[result].id }))
                  } else {
                    ProfilePicture(avatar: chatsListStore.chats[result].icon, placeholder: "person.3.fill")
                  }

                  Text(chatsListStore.chats[result].recipient?.username ?? chatsListStore.chats[result].name).lineLimit(1)
                  Spacer()
                  if chatsListStore.chats[result].unread != 0 {
                    Text(String(chatsListStore.chats[result].unread!))
                      .frame(minWidth: 16, minHeight: 16)
                      .background(Color.red)
                      .cornerRadius(10)
                  }
                }.contentShape(Rectangle())
              }.buttonStyle(.plain)
                .contextMenu {
                  Button {
                    copyToClipboard(String(chatsListStore.chats[result].association?.id ?? chatsListStore.chats[result].id))
                  } label: {
                    Label("Copy Chat ID", systemImage: "person.text.rectangle")
                  }
                }
            }
          }
        }
      }
      .onAppear {
        tryMessagesSubscription()
        tryTypingSubscription()
        tryCancelTypingSubscription()
      }
      .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("NavigateToPage"))) { notification in
        if let userInfo = notification.userInfo, let pageID = userInfo["to"] as? Int {
          chatOpen = chatsListStore.chats.first(where: { $0.id == pageID })?.association?.id ?? -1
        }
      }
    #endif
  }
}
