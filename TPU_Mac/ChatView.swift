//
//  ChatView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 1/10/2024.
//

import Apollo
import NukeUI
import PrivateUploaderAPI
import SDWebImageSwiftUI
import SwiftUI

struct ChatView: View {
  enum FocusedField {
    case editing, sending
  }
  
  @Binding var chatsList: [ChatsQuery.Data.Chat]
  @EnvironmentObject var store: Store
  @FocusState private var focusedField: FocusedField?
  @State private var chatMessages: [MessagesQuery.Data.Message] = []
  @Binding var chatOpen: Int
  @State private var unreadId: Int = -1
  @State private var editingId: Int = -1
  @State private var replyingId: Int = -1
  @State private var inputMessage: String = ""
  @State private var editingMessage: String = ""
  @State var apolloSubscription: Apollo.Cancellable?
  @State private var showingSheet: Bool = false
  //  @State private var hoverItem = -1
  
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
          focusedField = .sending
          if chatsList.first(where: { $0.association?.id == chatOpen })?.unread != 0 {
            if let unreadMessageIndex = chatMessages.firstIndex(where: { $0.id == chatsList.first(where: { $0.association?.id == chatOpen })?.association?.lastRead }) {
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
    Network.shared.apollo.perform(mutation: SendMessageMutation(input: SendMessageInput(content: inputMessage, associationId: chatsList.first(where: { $0.association?.id == chatOpen })?.association?.id ?? 0, attachments: [], replyId: replyId))) { result in
      switch result {
      case .success:
        replyingId = -1
        editingId = -1
        inputMessage = ""
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }
  
  func editMessage() {
    Network.shared.apollo.perform(mutation: EditMessageMutation(input: EditMessageInput(content: GraphQLNullable<String>(stringLiteral: editingMessage), attachments: [], messageId: editingId, associationId: chatsList.first(where: { $0.association?.id == chatOpen })?.association?.id ?? 0))) { result in
      switch result {
      case .success:
        replyingId = -1
        editingId = -1
        inputMessage = ""
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }
  
  func pinMessage(messageId: Int, pinned: Bool) {
    Network.shared.apollo.perform(mutation: EditMessageMutation(input: EditMessageInput(attachments: [], messageId: messageId, associationId: chatsList.first(where: { $0.association?.id == chatOpen })?.association?.id ?? 0, pinned: GraphQLNullable<Bool>(booleanLiteral: pinned)))) { result in
      switch result {
      case .success:
        replyingId = -1
        editingId = -1
        inputMessage = ""
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }
  
  func deleteMessage(messageId: Int) {
    Network.shared.apollo.perform(mutation: DeleteMessageMutation(input: DeleteMessageInput(messageId: messageId, associationId: chatsList.first(where: { $0.association?.id == chatOpen })?.association?.id ?? 0))) { result in
      switch result {
      case .success:
        replyingId = -1
        editingId = -1
        inputMessage = ""
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }
  
  func merge(message: MessagesQuery.Data.Message, previousMessage: MessagesQuery.Data.Message?) -> Bool {
    print(message.content)
    if message.userId == previousMessage?.userId && message.replyId == nil {
      return false
    }
    return true
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
            if chatOpen != -1 && chatsList.first(where: { $0.association?.id == chatOpen })?.id == message.chatId {
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
    #if !os(iOS)
      VStack {
        ScrollViewReader { proxy in
          ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
              ForEach(Array(chatMessages.enumerated()), id: \.element) { index, message in
                let dontMerge = merge(message: message, previousMessage: index != 0 ? chatMessages[index - 1] : nil)
                Spacer(minLength: dontMerge ? 16 : 0)
                if message.id == unreadId {
                  HStack {
                    VStack { Divider().background(.red) }
                    Text("New Message").foregroundStyle(.red)
                    VStack { Divider().background(.red) }
                  }
                }
                if message.reply != nil {
                  Button(action: {
                    proxy.scrollTo(message.replyId)
                  }) {
                    HStack {
                      Image(systemName: "arrow.turn.up.right").frame(width: 16, height: 16)
                      ProfilePicture(avatar: message.reply?.user?.avatar, size: 16)
                      Text(message.reply?.user?.username ?? "User has been deleted")
                      Text((message.reply?.content ?? "Message has been deleted").replacingOccurrences(of: "\n", with: "")).textSelection(.enabled).lineLimit(1)
                    }.padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 0))
                  }.buttonStyle(.plain)
                }
                HStack(alignment: .top, spacing: 6) {
                  if dontMerge {
                    ProfilePicture(avatar: message.user?.avatar)
                  } else {
                    Spacer().frame(width: 32)
                  }
                  VStack {
                    if dontMerge {
                      HStack {
                        Text(message.user?.username ?? "User has been deleted")
                        Text(DateUtils.dateFormat(message.createdAt))
                      }.frame(minWidth: 0,
                              maxWidth: .infinity,
                              minHeight: 0,
                              maxHeight: 10,
                              alignment: .topLeading)
                    }
                    if editingId != message.id {
                      Text(.init(message.content ?? "Message has been deleted"))
                        .textSelection(.enabled)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .leading)
                        .lineLimit(nil)
                    } else {
                      TextField("Keep it civil!", text: $editingMessage)
                        .focused($focusedField, equals: .editing)
                        .onExitCommand(perform: {
                          editingId = -1
                          focusedField = .sending
                        })
                        .onSubmit {
                          editMessage()
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    ForEach(message.embeds, id: \.self) { embed in
                      VStack {
                        VStack {
                          if let text = embed.text, embed.text != [] {
                            ForEach(Array(text.enumerated()), id: \.element) { index, line in
                              if index == 0 {
                                Text(line.text ?? "").font(.title2).lineLimit(1)
                              } else {
                                Text(line.text ?? "")
                              }
                            }
                          }
                          if let media = embed.media, embed.media != [] {
                            ForEach(media, id: \.self) { img in
                              if img.mimeType != "image/gif" {
                                LazyImage(url: URL(string: img.attachment == nil ? ("https://i.electrics01.com" + (img.proxyUrl ?? "")) : ("https://i.electrics01.com/i/" + (img.attachment ?? "")))) { state in
                                  if let image = state.image {
                                    image.resizable().aspectRatio(contentMode: .fit)
                                    //                                .onAppear {
                                    ////                                  if chatMessages.count != 0 {
                                    ////                                    proxy.scrollTo(0, anchor: .bottom)
                                    ////                                  }
                                    //                                }
                                  } else if state.error != nil {
                                    Color.red
                                  } else {
                                    ProgressView()
                                  }
                                }
                              } else {
                                HStack {
                                  WebImage(url: URL(string: img.attachment == nil ? ("https://i.electrics01.com" + (img.proxyUrl ?? "")) : ("https://i.electrics01.com/i/" + (img.attachment ?? "")))) { image in
                                    image.resizable().aspectRatio(contentMode: .fit)
                                  } placeholder: {
                                    ProgressView()
                                  }
                                }
                              }
                            }.frame(minWidth: 0, maxWidth: 600, minHeight: 0, maxHeight: 400).clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                          }
                        }.padding(embed.text ?? [] != [] ? 8 : 0)
                      }.frame(minWidth: 0, maxWidth: 600).background().clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                  }
                  Button(action: {
                    if replyingId != message.id {
                      replyingId = message.id
                    } else { replyingId = -1 }
                  }) {
                    Image(systemName: "arrowshape.turn.up.left.fill").frame(width: 16, height: 16)
                  }
                  Button(action: {
                    deleteMessage(messageId: message.id)
                  }) {
                    Image(systemName: "trash.fill").frame(width: 16, height: 16)
                  }
                  Button(action: {
                    pinMessage(messageId: message.id, pinned: message.pinned)
                  }) {
                    Image(systemName: message.pinned ? "pin.slash.fill" : "pin.fill").frame(width: 16, height: 16)
                  }
                  if store.coreUser?.id == message.userId {
                    Button(action: {
                      replyingId = -1
                      if editingId != message.id {
                        editingId = message.id
                        editingMessage = message.content ?? ""
                        focusedField = .editing
                      } else { editingId = -1 }
                    }) {
                      Image(systemName: "pencil").frame(width: 16, height: 16)
                    }
                  }
                }.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)).id(message.id)
                //                  .background(Color(hoverItem == message.id ? Color.primary : .clear))
                //                  .onHover(perform: { _ in
                //                    hoverItem = message.id
                //                  })
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
              Text(chatMessages.last(where: { $0.id == replyingId })?.user?.username ?? "User has been deleted")
              Text(chatMessages.last(where: { $0.id == replyingId })?.content ?? "Message has been deleted")
                .textSelection(.enabled)
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
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .navigationTitle(chatsList.first(where: { $0.association?.id == chatOpen })?.recipient?.username ?? chatsList.first(where: { $0.association?.id == chatOpen })?.name ?? "")
        #if os(iOS)
          .navigationBarTitleDisplayMode(.inline)
          .toolbar(content: {
            ToolbarItem(placement: .principal) {
              Text(chatsList[chatOpen].recipient?.username ?? chatsList[chatOpen].name)
                .bold()
                .onTapGesture {
                  showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                  List {
                    ForEach(0 ..< chatsList[chatOpen].users.count, id: \.self) { result in
                      Button(action: { print("Clicked: " + (chatsList[chatOpen].users[result].user?.username ?? "User's name could not be found")) }) {
                        HStack {
                          ProfilePicture(avatar: chatsList[chatOpen].users[result].user?.avatar)
                          Text(chatsList[chatOpen].users[result].user?.username ?? "User's name could not be found")
                          Spacer()
                        }.contentShape(Rectangle())
                      }.buttonStyle(.plain)
                    }
                  }.padding(EdgeInsets(top: -8, leading: -10, bottom: -8, trailing: 0))
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
    #endif
  }
}
