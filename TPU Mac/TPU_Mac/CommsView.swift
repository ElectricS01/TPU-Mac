//
//  CommsView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 3/11/2023.
//

import Apollo
import PrivateUploaderAPI
import SwiftUI

struct CommsView: View {
  @State private var chatsList: [ChatsQuery.Data.Chat] = []
  @State private var chatMessages: [MessagesQuery.Data.Message] = []
  @State private var chatOpen: Int = -1
  @State private var editingId: Int = -1
  @State private var replyingId: Int = -1
  @State private var inputMessage: String = ""
  @State private var editingMessage: String = ""
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
    getMessages(chat: chatsList[chatId ?? 0].association?.id ?? 0) { result in
      switch result {
      case .success(let graphQLResult):
        if let unwrapped = graphQLResult.data {
          chatMessages = unwrapped.messages
          chatOpen = chatId ?? -1
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func chats(completion: @escaping (Result<GraphQLResult<ChatsQuery.Data>, Error>) -> Void) {
    Network.shared.apollo.fetch(query: ChatsQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
      switch result {
      case .success:
        completion(result)
      case .failure(let error):
        print("Failure! Error: \(error)")
        completion(result)
      }
    }
  }
  
  func sendMessage() {
    var replyId: GraphQLNullable<Int> = nil
    if replyingId != -1 { replyId = GraphQLNullable<Int>(integerLiteral: replyingId) }
    Network.shared.apollo.perform(mutation: SendMessageMutation(input: SendMessageInput(content: inputMessage, associationId: chatsList[chatOpen].association?.id ?? 0, attachments: [], replyId: replyId))) { result in
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
    Network.shared.apollo.perform(mutation: EditMessageMutation(input: EditMessageInput(content: GraphQLNullable<String>(stringLiteral: editingMessage), attachments: [], messageId: editingId, associationId: chatsList[chatOpen].association?.id ?? 0))) { result in
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
  
  var body: some View {
    #if os(macOS)
    HSplitView {
      List {
        ForEach(0 ..< chatsList.count, id: \.self) { result in
          Button(action: { getChat(chatId: result) }) {
            HStack {
              ProfilePicture(
                avatar: (chatsList[result].recipient?.avatar ?? chatsList[result].icon), size: 32
              )
              Text(chatsList[result].recipient?.username ?? chatsList[result].name)
                .lineLimit(1)
              Spacer()
              if chatsList[result].unread != 0 {
                Text(String(chatsList[result].unread!))
                  .frame(minWidth: 16, minHeight: 16)
                  .background(Color.red)
                  .cornerRadius(10)
              }
            }.contentShape(Rectangle())
          }
          .buttonStyle(.plain)
        }
      }
      .frame(width: 150)
      .padding(EdgeInsets(top: -8, leading: -10, bottom: -8, trailing: 0))
      if chatOpen != -1 {
        ScrollViewReader { proxy in
          ScrollView {
            VStack(alignment: .leading, spacing: 6) {
              ForEach(chatMessages.reversed(), id: \.self) { message in
                if message.reply != nil {
                  HStack {
                    Image(systemName: "arrow.turn.up.right").frame(width: 16, height: 16)
                    Text(message.reply?.user?.username ?? "User has been deleted")
                    Text((message.reply?.content ?? "Message has been deleted").replacingOccurrences(of: "\n", with: "")).textSelection(.enabled).lineLimit(1)
                  }.padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 0))
                }
                HStack(alignment: .top, spacing: 6) {
                  ProfilePicture(avatar: message.user?.avatar, size: 32)
                  VStack {
                    HStack {
                      Text(message.user?.username ?? "User has been deleted")
                      if let date = inputDateFormatter.date(from: message.createdAt) {
                        let formattedDate = outputDateFormatter.string(from: date)
                        Text(formattedDate)
                      } else {
                        Text("Invalid Date")
                      }
                    }.frame(minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: 6,
                            alignment: .topLeading)
                    if editingId != message.id {
                      Text(.init(message.content ?? "Message has been deleted"))
                        .textSelection(.enabled)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               minHeight: 0,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                        .lineLimit(nil)
                    } else {
                      TextField("Keep it civil!", text: $editingMessage)
                        .onSubmit {
                          editMessage()
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    ForEach(message.embeds, id: \.self) { embed in
                      if embed.media != [] {
                        CacheAsyncImage(
                          url: URL(string: "https://i.electrics01.com" + (embed.media?[0].proxyUrl ?? ""))
                        ) { image in
                          image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .onAppear {
                              if chatMessages.count != 0 {
                                proxy.scrollTo(chatMessages.first?.id)
                              }
                            }
                        } placeholder: {
                          ProgressView()
                        }.frame(minWidth: 0, maxWidth: 400, minHeight: 0, maxHeight: 400, alignment: .topLeading)
                      }
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
                    replyingId = -1
                    if editingId != message.id {
                      editingId = message.id
                      editingMessage = message.content ?? ""
                    } else { editingId = -1 }
                  }) {
                    Image(systemName: "pencil").frame(width: 16, height: 16)
                  }
                }.padding(4)
                  .id(message.id)
                //                  .background(Color(hoverItem == message.id ? Color.primary : .clear))
                //                  .onHover(perform: { _ in
                //                    hoverItem = message.id
                //                  })
              }.padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 12))
            }.frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
            .onAppear {
              if chatMessages.count != 0 {
                proxy.scrollTo(chatMessages.first?.id)
              }
            }
            .onChange(of: chatMessages) {
              proxy.scrollTo(chatMessages.first?.id)
            }
          }
          if replyingId != -1 {
            HStack {
              Image(systemName: "arrow.turn.up.right").frame(width: 16, height: 16)
              Text(chatMessages.first(where: { $0.id == replyingId })?.user?.username ?? "User has been deleted")
              Text(chatMessages.first(where: { $0.id == replyingId })?.content ?? "Message has been deleted")
                .textSelection(.enabled)
                .lineLimit(1)
                .onAppear {
                  if chatMessages.count != 0 {
                    proxy.scrollTo(chatMessages.first?.id)
                  }
                }
            }.padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 0))
              .frame(minWidth: 0,
                     maxWidth: .infinity,
                     alignment: .topLeading)
          }
          TextField("Keep it civil!", text: $inputMessage)
            .onSubmit {
              sendMessage()
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .navigationTitle(chatsList[chatOpen].recipient?.username ?? chatsList[chatOpen].name)
        List {
          ForEach(0 ..< chatsList[chatOpen].users.count, id: \.self) { result in
            Button(action: { print("Clicked: " + (chatsList[chatOpen].users[result].user?.username ?? "User's name could not be found")) }) {
              HStack {
                ProfilePicture(avatar: chatsList[chatOpen].users[result].user?.avatar, size: 32)
                Text(chatsList[chatOpen].users[result].user?.username ?? "User's name could not be found")
                Spacer()
              }.contentShape(Rectangle())
            }.buttonStyle(.plain)
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
      chats { result in
        switch result {
        case .success(let graphQLResult):
          if let unwrapped = graphQLResult.data {
            chatsList = unwrapped.chats
          }
        case .failure(let error):
          print(error)
        }
      }
    }
    #else
    List {
      ForEach(0 ..< chatsList.count, id: \.self) { result in
        Button(action: { getChat(chatId: result) }) {
          HStack {
            ProfilePicture(
              avatar: (chatsList[result].recipient?.avatar ?? chatsList[result].icon), size: 32
            )
            Text(chatsList[result].recipient?.username ?? chatsList[result].name)
              .lineLimit(1)
            Spacer()
            if chatsList[result].unread != 0 {
              Text(String(chatsList[result].unread!))
                .frame(minWidth: 16, minHeight: 16)
                .background(Color.red)
                .cornerRadius(10)
            }
          }.contentShape(Rectangle())
        }
        .buttonStyle(.plain)
      }
    }
    .padding(EdgeInsets(top: -8, leading: -10, bottom: -8, trailing: 0))
    if chatOpen != -1 {
      ScrollViewReader { proxy in
        ScrollView {
          VStack(alignment: .leading, spacing: 6) {
            ForEach(chatMessages.reversed(), id: \.self) { message in
              if message.reply != nil {
                HStack {
                  Image(systemName: "arrow.turn.up.right").frame(width: 16, height: 16)
                  Text(message.reply?.user?.username ?? "User has been deleted")
                  Text((message.reply?.content ?? "Message has been deleted").replacingOccurrences(of: "\n", with: "")).textSelection(.enabled).lineLimit(1)
                }.padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 0))
              }
              HStack(alignment: .top, spacing: 6) {
                ProfilePicture(avatar: message.user?.avatar, size: 32)
                VStack {
                  HStack {
                    Text(message.user?.username ?? "User has been deleted")
                    if let date = inputDateFormatter.date(from: message.createdAt) {
                      let formattedDate = outputDateFormatter.string(from: date)
                      Text(formattedDate)
                    } else {
                      Text("Invalid Date")
                    }
                  }.frame(minWidth: 0,
                          maxWidth: .infinity,
                          minHeight: 0,
                          maxHeight: 6,
                          alignment: .topLeading)
                  if editingId != message.id {
                    Text(.init(message.content ?? "Message has been deleted"))
                      .textSelection(.enabled)
                      .frame(minWidth: 0,
                             maxWidth: .infinity,
                             minHeight: 0,
                             maxHeight: .infinity,
                             alignment: .topLeading)
                      .lineLimit(nil)
                  } else {
                    TextField("Keep it civil!", text: $editingMessage)
                      .onSubmit {
                        editMessage()
                      }
                      .textFieldStyle(RoundedBorderTextFieldStyle())
                  }
                  ForEach(message.embeds, id: \.self) { embed in
                    if embed.media != [] {
                      CacheAsyncImage(
                        url: URL(string: "https://i.electrics01.com" + (embed.media?[0].proxyUrl ?? ""))
                      ) { image in
                        image.resizable()
                          .aspectRatio(contentMode: .fit)
                          .onAppear {
                            if chatMessages.count != 0 {
                              proxy.scrollTo(chatMessages.first?.id)
                            }
                          }
                      } placeholder: {
                        ProgressView()
                      }.frame(minWidth: 0, maxWidth: 400, minHeight: 0, maxHeight: 400, alignment: .topLeading)
                    }
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
                  replyingId = -1
                  if editingId != message.id {
                    editingId = message.id
                    editingMessage = message.content ?? ""
                  } else { editingId = -1 }
                }) {
                  Image(systemName: "pencil").frame(width: 16, height: 16)
                }
              }.padding(4)
                .id(message.id)
              //                  .background(Color(hoverItem == message.id ? Color.primary : .clear))
              //                  .onHover(perform: { _ in
              //                    hoverItem = message.id
              //                  })
            }.padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 12))
          }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
          .onAppear {
            if chatMessages.count != 0 {
              proxy.scrollTo(chatMessages.first?.id)
            }
          }
          .onChange(of: chatMessages) {
            proxy.scrollTo(chatMessages.first?.id)
          }
        }
        if replyingId != -1 {
          HStack {
            Image(systemName: "arrow.turn.up.right").frame(width: 16, height: 16)
            Text(chatMessages.first(where: { $0.id == replyingId })?.user?.username ?? "User has been deleted")
            Text(chatMessages.first(where: { $0.id == replyingId })?.content ?? "Message has been deleted")
              .textSelection(.enabled)
              .lineLimit(1)
              .onAppear {
                if chatMessages.count != 0 {
                  proxy.scrollTo(chatMessages.first?.id)
                }
              }
          }.padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 0))
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .topLeading)
        }
        TextField("Keep it civil!", text: $inputMessage)
          .onSubmit {
            sendMessage()
          }
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      .navigationTitle(chatsList[chatOpen].recipient?.username ?? chatsList[chatOpen].name)
      List {
        ForEach(0 ..< chatsList[chatOpen].users.count, id: \.self) { result in
          Button(action: { print("Clicked: " + (chatsList[chatOpen].users[result].user?.username ?? "User's name could not be found")) }) {
            HStack {
              ProfilePicture(avatar: chatsList[chatOpen].users[result].user?.avatar, size: 32)
              Text(chatsList[chatOpen].users[result].user?.username ?? "User's name could not be found")
              Spacer()
            }.contentShape(Rectangle())
          }.buttonStyle(.plain)
        }
      }
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
      .navigationTitle("Comms")
      .onAppear {
        chats { result in
          switch result {
          case .success(let graphQLResult):
            if let unwrapped = graphQLResult.data {
              chatsList = unwrapped.chats
            }
          case .failure(let error):
            print(error)
          }
        }
      }
    }
    #endif
  }
}
