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
  @FocusState private var focusedField: FocusedField?
  @State private var chatsList: [ChatsQuery.Data.Chat] = []
  @State private var chatMessages: [MessagesQuery.Data.Message] = []
  @State private var chatOpen: Int = -1
  @State private var unreadId: Int = -1
  @State private var editingId: Int = -1
  @State private var replyingId: Int = -1
  @State private var inputMessage: String = ""
  @State private var editingMessage: String = ""
  @State var apolloSubscription: Apollo.Cancellable?
  @State private var notifications: Int = 0
  //  @State private var hoverItem = -1
  
  func getChats() {
    Network.shared.apollo.fetch(query: ChatsQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
      switch result {
      case .success(let graphQLResult):
        if let unwrapped = graphQLResult.data {
          chatsList = unwrapped.chats
        }
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }
  
  func convertToMessage(subscriptionObject: UpdateMessagesSubscription.Data.OnMessage.Message) -> MessagesQuery.Data.Message {
    var messageData = DataDict(data: [:], fulfilledFragments: Set<ObjectIdentifier>())

    messageData["id"] = subscriptionObject.id
    messageData["createdAt"] = subscriptionObject.createdAt
    messageData["updatedAt"] = subscriptionObject.updatedAt
    messageData["chatId"] = subscriptionObject.chatId
    messageData["userId"] = subscriptionObject.userId
    messageData["content"] = subscriptionObject.content
    messageData["type"] = subscriptionObject.type
    messageData["emoji"] = subscriptionObject.emoji
    messageData["embeds"] = subscriptionObject.embeds
    messageData["reply"] = subscriptionObject.reply
    messageData["user"] = subscriptionObject.user
    messageData["edited"] = subscriptionObject.edited
    messageData["editedAt"] = subscriptionObject.editedAt
    messageData["replyId"] = subscriptionObject.replyId
    messageData["pinned"] = subscriptionObject.pinned
    messageData["readReceipts"] = subscriptionObject.readReceipts
    
    let message = MessagesQuery.Data.Message(_dataDict: messageData)

    return message
  }
  
  func editToMessage(messageObject: MessagesQuery.Data.Message, editObject: EditedMessageSubscription.Data.OnEditMessage.Message) -> MessagesQuery.Data.Message {
    var messageData = DataDict(data: [:], fulfilledFragments: Set<ObjectIdentifier>())
    
    messageData["id"] = editObject.id
    messageData["createdAt"] = messageObject.createdAt
    messageData["updatedAt"] = messageObject.updatedAt
    messageData["chatId"] = messageObject.chatId
    messageData["userId"] = editObject.userId
    messageData["content"] = editObject.content
    messageData["type"] = messageObject.type
    messageData["emoji"] = editObject.emoji
    messageData["embeds"] = editObject.embeds
    messageData["reply"] = messageObject.reply
    messageData["user"] = messageObject.user
    messageData["edited"] = editObject.edited
    messageData["editedAt"] = editObject.editedAt
    messageData["replyId"] = messageObject.replyId
    messageData["pinned"] = editObject.pinned
    messageData["readReceipts"] = messageObject.readReceipts
    
    let message = MessagesQuery.Data.Message(_dataDict: messageData)
    
    return message
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
    
    let chat = ChatsQuery.Data.Chat(_dataDict: chatData)
    
    return chat
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
      if let error = error {
        print("Error scheduling notification: \(error)")
      }
    }
  }
  
  func messagesSubscription() {
    if apolloSubscription == nil {
      apolloSubscription = Network.shared.apollo.subscribe(subscription: UpdateMessagesSubscription()) { result in
        switch result {
        case .success(let graphQLResult):
          if let message = graphQLResult.data?.onMessage.message {
            if chatOpen != -1 && chatsList.first(where: { $0.association?.id == chatOpen })?.id == message.chatId {
              let newMessage = convertToMessage(subscriptionObject: message)
              chatMessages.append(newMessage)
            }
            
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
        case .failure(let error):
          print("Failed to subscribe \(error)")
        }
      }
    }
  }
  
  func editingSubscription() {
    _ = Network.shared.apollo.subscribe(subscription: EditedMessageSubscription()) { result in
      print("e")
      switch result {
      case .success(let graphQLResult):
        if let message = graphQLResult.data?.onEditMessage.message {
          let index = chatMessages.firstIndex(where: { $0.id == message.id })
          let newMessage = editToMessage(messageObject: chatMessages[index ?? 0], editObject: message)
          chatMessages[index ?? 0] = newMessage
        }
      case .failure(let error):
        print("Failed to subscribe \(error)")
      }
    }
  }

  var body: some View {
    #if os(macOS)
      HStack {
        List {
          ForEach(0 ..< chatsList.count, id: \.self) { result in
            Button(action: { chatOpen = chatsList[result].association?.id ?? -1 }) {
              HStack {
                ProfilePicture(avatar: chatsList[result].recipient?.avatar ?? chatsList[result].icon)
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
          }
        }
        .frame(width: 150)
        .padding(EdgeInsets(top: -8, leading: -10, bottom: -8, trailing: 0))
        if chatOpen != -1 {
          ChatView(chatsList: $chatsList, chatOpen: $chatOpen)
          List {
            Section(header: Text("Online")) {
              ForEach(0 ..< (chatsList.first(where: { $0.association?.id == chatOpen })?.users.count ?? 0), id: \.self) { index in
                let user = store.coreUsers.unsafelyUnwrapped.first { $0.id == chatsList.first(where: { $0.association?.id == chatOpen })?.users[index].user?.id }
                if let user = user, user.status.value != .offline {
                  Button(action: {
                    print(user.username)
                  }) {
                    HStack {
                      Circle().fill(user.status.value != .online ? user.status.value == .busy ? .red : .yellow : .green).frame(width: 6, height: 6)
                      ProfilePicture(avatar: user.avatar)
                      Text(user.username)
                      Spacer()
                    }.contentShape(Rectangle())
                  }.buttonStyle(.plain)
                    .contextMenu {
                      if user.status.rawValue == "ACCEPTED" {
                        Button {
                          print("Action for context menu item 1")
                        } label: {
                          Label("Add friend", systemImage: "person.badge.plus")
                        }
                      }
                    }
                }
              }
            }
            Section(header: Text("Offline")) {
              ForEach(0 ..< (chatsList.first(where: { $0.association?.id == chatOpen })?.users.count ?? 0), id: \.self) { index in
                let user = store.coreUsers.unsafelyUnwrapped.first { $0.id == chatsList.first(where: { $0.association?.id == chatOpen })?.users[index].user?.id }
                if let user = user, user.status.value == .offline {
                  Button(action: {
                    print("Clicked: " + (user.username))
                  }) {
                    HStack {
                      Circle().fill(.gray).frame(width: 6, height: 6)
                      ProfilePicture(avatar: user.avatar)
                      Text(user.username).foregroundStyle(.gray)
                      Spacer()
                    }.contentShape(Rectangle())
                  }.buttonStyle(.plain)
                    .contextMenu {
                      if user.status.rawValue == "ACCEPTED" {
                        Button {
                          print("Action for context menu item 1")
                        } label: {
                          Label("Add friend", systemImage: "person.badge.plus")
                        }
                      }
                    }
                }
              }
            }
          }.frame(width: 150)
            .padding(EdgeInsets(top: -8, leading: -10, bottom: -8, trailing: 0))
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
        messagesSubscription()
        editingSubscription()
      }
      .onDisappear {
        if let subscription = apolloSubscription {
          subscription.cancel()
          apolloSubscription = nil
        }
      }
      .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("NavigateToPage"))) { notification in
        if let userInfo = notification.userInfo, let pageID = userInfo["to"] as? Int {
          chatOpen = chatsList.first(where: { $0.id == pageID })?.association?.id ?? -1
        }
      }
    #else
      NavigationStack {
        List {
          ForEach(0 ..< chatsList.count, id: \.self) { result in
            NavigationLink(destination: ChatView(chatsList: $chatsList, chatOpen: .constant(chatsList[result].association?.id ?? -1))) {
              HStack {
                ProfilePicture(avatar: chatsList[result].recipient?.avatar ?? chatsList[result].icon)
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
          }
        }
        .onAppear {
          getChats()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("NavigateToPage"))) { notification in
          if let userInfo = notification.userInfo, let pageID = userInfo["to"] as? Int {
            chatOpen = chatsList.first(where: { $0.id == pageID })?.association?.id ?? -1
          }
        }
      }
    #endif
  }
}
