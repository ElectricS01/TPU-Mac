//
//  ChatView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 1/10/2024.
//

import Apollo
import MarkdownUI
import PrivateUploaderAPI
import SwiftUI

enum FocusedField {
  case editing, sending
}

func renderRichText(
  _ text: String,
  users: [StateQuery.Data.TrackedUser]
) -> String {
  print(text)
  var result = text as NSString
  
  let regex = try! NSRegularExpression(
    pattern: #"<@(\d+)>|:([a-zA-Z0-9_+-]+):"#
  )
  
  let matches = regex.matches(
    in: text,
    range: NSRange(location: 0, length: result.length)
  )
  
  for match in matches.reversed() {
    let fullRange = match.range(at: 0)
    
    if match.range(at: 1).location != NSNotFound {
      let idString = result.substring(with: match.range(at: 1))
      let idInt = Int(idString)
      
      let username = users.first(where: { $0.id == idInt })?.username ?? "Unknown"
      
      let replacement = "[@\(username)](mention://\(idString))"
      result = result.replacingCharacters(in: fullRange, with: replacement) as NSString
      continue
    }
    
    if match.range(at: 2).location != NSNotFound {
      let name = result.substring(with: match.range(at: 2))
      
      if let emoji = EmojiMapper.shared.map[name] {
        result = result.replacingCharacters(in: fullRange, with: emoji) as NSString
      }
    }
  }
  
  return result as String
}

struct ChatView: View {
  @Binding var chatsList: [ChatsQuery.Data.Chat]
  @EnvironmentObject var store: Store
  @FocusState private var focusedField: FocusedField?
  @State private var chatMessages: [MessagesQuery.Data.Message] = []
  @Binding var chatOpen: Int
  @State private var unreadId: Int = -1
  @State private var editingId: Int = -1
  @State private var replyingId: Int = -1
  @State private var inputMessage: String = ""
  @State var apolloSubscription: Apollo.Cancellable?
  @State private var showingSheet: Bool = false
  
  private var currentChat: ChatsQuery.Data.Chat? {
    chatsList.first { $0.association?.id == chatOpen }
  }
  
  private var replyingMessage: MessagesQuery.Data.Message? {
    chatMessages.last { $0.id == replyingId }
  }
  
  private var chatUsers: [StateQuery.Data.TrackedUser] {
    guard let currentUsers = currentChat?.users,
          let coreUsers = store.coreUsers
    else { return [] }
    
    return currentUsers.compactMap { member in
      coreUsers.first { $0.id == member.user?.id }
    }
  }
  
  func getMessages(chat: Int, completion: @escaping (Result<GraphQLResult<MessagesQuery.Data>, Error>) -> Void) {
    Network.shared.apollo.fetch(query: MessagesQuery(input: InfiniteMessagesInput(associationId: chat, position: GraphQLNullable(ScrollPosition.top), limit: 50)), cachePolicy: .fetchIgnoringCacheData) { result in
      switch result {
      case .success:
        completion(result)
      case .failure(let error):
        print("Failure! Error: \(error)")
        completion(result)
      }
    }
  }
  
  func getChat(chatId: Int?) {
    getMessages(chat: chatId ?? 0) { result in
      switch result {
      case .success(let graphQLResult):
        if let unwrapped = graphQLResult.data {
          chatMessages = unwrapped.messages.reversed()
          chatOpen = chatId ?? -1
          #if os(macOS)
            focusedField = .sending
          #endif
          if currentChat?.unread != 0 {
            if let unreadMessageIndex = chatMessages.firstIndex(where: { $0.id == currentChat?.association?.lastRead }) {
              unreadId = chatMessages[unreadMessageIndex + 1].id
            } else {
              unreadId = -1
            }
          }
        }
      case .failure(let error):
        print(error)
      }
    }
  }

  func sendMessage() {
    var replyId: GraphQLNullable<Int> = nil
    if replyingId != -1 { replyId = GraphQLNullable<Int>(integerLiteral: replyingId) }
    Network.shared.apollo.perform(mutation: SendMessageMutation(input: SendMessageInput(content: inputMessage, associationId: currentChat?.association?.id ?? 0, attachments: [], replyId: replyId))) { result in
      switch result {
      case .success:
        replyingId = -1
        inputMessage = ""
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
  
  func messagesSubscription() {
    if apolloSubscription == nil {
      apolloSubscription = Network.shared.apollo.subscribe(subscription: UpdateMessagesSubscription()) { result in
        switch result {
        case .success(let graphQLResult):
          if let message = graphQLResult.data?.onMessage.message {
            if chatOpen != -1 && currentChat?.id == message.chatId {
              let newMessage = convertToMessage(subscriptionObject: message)
              chatMessages.append(newMessage)
            }
          }
        case .failure(let error):
          print("Failed to subscribe \(error)")
        }
      }
    }
  }
  
  func editingSubscription() {
    _ = Network.shared.apollo.subscribe(subscription: EditedMessageSubscription()) { result in
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
  
  func deletingSubscription() {
    _ = Network.shared.apollo.subscribe(subscription: DeletedMessageSubscription()) { result in
      switch result {
      case .success(let graphQLResult):
        if let message = graphQLResult.data?.onDeleteMessage.id {
          if let index = chatMessages.firstIndex(where: { $0.id == message }) {
            chatMessages.remove(at: index)
          }
        }
      case .failure(let error):
        print("Failed to subscribe \(error)")
      }
    }
  }
  
  func handleReplyClick(id: Int) {
    replyingId = id
  }
  
  func handleInputClear() {
    replyingId = -1
    editingId = -1
    inputMessage = ""
  }
  
  var body: some View {
    VStack {
      ScrollViewReader { proxy in
        ScrollView {
          LazyVStack(alignment: .leading, spacing: 0) {
            ForEach(chatMessages.indices, id: \.self) { index in
              let message = chatMessages[index]
              let previous = index > 0 ? chatMessages[index - 1] : nil
              
              ChatMessageView(message: message, previousMessage: previous, chatOpen: chatOpen, scrollProxy: proxy, focusedField: $focusedField, unread: message.id == unreadId, onReplyClick: handleReplyClick, editingId: $editingId, onInputClear: handleInputClear)
            }.padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 12))
          }
          .id(0)
          .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
          .onAppear {
            if chatMessages.count != 0 {
              proxy.scrollTo(0, anchor: .bottom)
            }
          }
          .onChange(of: chatMessages) {
            proxy.scrollTo(0, anchor: .bottom)
          }
        }
        if replyingId != -1 {
          HStack {
            Image(systemName: "arrow.turn.up.right").frame(width: 16, height: 16)
            Text(replyingMessage?.user?.username ?? "User has been deleted")
            Markdown(renderRichText(replyingMessage?.content ?? "Message has been deleted", users: store.coreUsers ?? []))
              .lineLimit(1)
              .onAppear {
                if chatMessages.count != 0 {
                  proxy.scrollTo(0, anchor: .bottom)
                }
              }
          }.padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 0))
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .topLeading)
        }
        TextField("Keep it civil!", text: $inputMessage)
          .focused($focusedField, equals: .sending)
          .onSubmit {
            sendMessage()
          }
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
              .onEnded { value in
                if value.translation.height > 0 {
                  focusedField = .none
                }
              })
        #if !os(iOS)
              .onExitCommand(perform: {
                replyingId = -1
              })
        #endif
      }
      .navigationTitle(currentChat?.recipient?.username ?? currentChat?.name ?? "Chat name error")
      .environment(\.openURL, OpenURLAction { url in
        if url.scheme == "mention" {
          let id = url.host ?? ""
          print("User tapped:", id)
          return .handled
        }
        
        return .systemAction
      })
      #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar(content: {
        ToolbarItem(placement: .principal) {
          Text(currentChat?.recipient?.username ?? currentChat?.name ?? "Chat name error")
            .bold()
            .onTapGesture {
              showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
              List {
                Section("Online") {
                  ForEach(chatUsers.filter { $0.status.value != .offline }, id: \.id) { user in
                    UserRow(user: user)
                  }
                }
                  
                Section("Offline") {
                  ForEach(chatUsers.filter { $0.status.value == .offline }, id: \.id) { user in
                    UserRow(user: user, isOffline: true)
                  }
                }
              }
            }
        }
      })
      #endif
    }
    .navigationTitle("Comms")
    .onAppear {
      getChat(chatId: chatOpen)
      messagesSubscription()
      editingSubscription()
      deletingSubscription()
    }
    .onChange(of: chatOpen) {
      getChat(chatId: chatOpen)
    }
    .onDisappear {
      if let subscription = apolloSubscription {
        subscription.cancel()
        apolloSubscription = nil
      }
    }
  }
}
