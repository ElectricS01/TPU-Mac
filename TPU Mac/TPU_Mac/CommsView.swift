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
  @State private var inputMessage: String = ""
//  @State private var hoverItem = -1
  
  func messages(chat: Int, completion: @escaping (Result<GraphQLResult<MessagesQuery.Data>, Error>) -> Void) {
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
  
  func openChat(chatId: Int?) {
    messages(chat: chatsList[chatId ?? 0].association?.id ?? 0) { result in
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
    Network.shared.apollo.fetch(query: ChatsQuery()) { result in
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
    Network.shared.apollo.perform(mutation: SendMessageMutation(input: SendMessageInput(content: inputMessage, associationId: chatsList[chatOpen].association?.id ?? 0, attachments: []))) { result in
      switch result {
      case .success(let graphQLResult):
        print(graphQLResult)
        inputMessage = ""
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }
  
  var body: some View {
    HSplitView {
      List {
        ForEach(0 ..< chatsList.count, id: \.self) { result in
          Button(action: { openChat(chatId: result) }) {
            HStack {
              if (chatsList[result].recipient?.avatar ?? chatsList[result].icon) != nil && ((chatsList[result].recipient?.avatar?.count ?? chatsList[result].icon?.count) ?? 0) <= 21 {
                CacheAsyncImage(
                  url: URL(string: "https://i.electrics01.com/i/" + (chatsList[result].recipient?.avatar ?? chatsList[result].icon ?? ""))
                ) { image in
                  image.resizable()
                } placeholder: {
                  ProgressView()
                }
                .frame(width: 32, height: 32)
                .cornerRadius(16)
              } else {
                Image(systemName: "person.crop.circle").frame(width: 32, height: 32).font(.largeTitle)
              }
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
                HStack(alignment: .top, spacing: 6) {
                  if (message.user?.avatar) != nil {
                    CacheAsyncImage(
                      url: URL(string: "https://i.electrics01.com/i/" + (message.user?.avatar ?? ""))
                    ) { image in
                      image.resizable()
                    } placeholder: {
                      ProgressView()
                    }
                    .frame(width: 32, height: 32)
                    .cornerRadius(16)
                  } else {
                    Image(systemName: "person.crop.circle").frame(width: 32, height: 32).font(.largeTitle)
                  }
                  VStack {
                    HStack {
                      Text(message.user?.username ?? "Error")
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
                    Text(.init(message.content ?? "Error"))
                      .textSelection(.enabled)
                      .frame(minWidth: 0,
                             maxWidth: .infinity,
                             minHeight: 0,
                             maxHeight: .infinity,
                             alignment: .topLeading)
                      .lineLimit(nil)
                    ForEach(message.embeds, id: \.self) { embed in
                      CacheAsyncImage(
                        url: URL(string: "https://i.electrics01.com" + (embed.media?[0].proxyUrl ?? ""))
                      ) { image in
                        image.resizable()
                          .aspectRatio(contentMode: .fit)
                      } placeholder: {
                        ProgressView()
                      }.frame(minWidth: 0, maxWidth: 400, minHeight: 0, maxHeight: 400, alignment: .topLeading)
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                  }
                }.padding(4)
                  .id(message.id)
                //                  .background(Color(hoverItem == message.id ? Color.primary : .clear))
                //                  .onHover(perform: { _ in
                //                    hoverItem = message.id
                //                  })
              }
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
  }
}
