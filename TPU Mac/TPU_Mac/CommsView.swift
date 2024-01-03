//
//  CommsView.swift
//  TPU Mac
//
//  Created by ElectricS01  on 3/11/2023.
//

import SwiftUI
import Apollo
import PrivateUploaderAPI

struct CommsView: View {
  @State private var chatsList: [ChatsQuery.Data.Chat] = []
  @State private var chatMessages: [MessagesQuery.Data.Message] = []
  @State private var chatOpen: Int = 0
  @State private var inputMessage: String = ""
  
  func messages(chat: Int, completion: @escaping (Result<GraphQLResult<MessagesQuery.Data>, Error>) -> Void) {
    Network.shared.apollo.fetch(query: MessagesQuery(input: InfiniteMessagesInput(associationId: chat, position: GraphQLNullable(ScrollPosition.top), limit: 50 ))) { result in
      switch result {
      case .success:
        completion(result)
      case .failure(let error):
        print("Failure! Error: \(error)")
        completion(result)
      }
    }
  }
  
  func openChat (chatId: Int?) {
    messages(chat: chatId ?? 0) { result in
      switch result {
      case .success(let graphQLResult):
        print(graphQLResult)
        if let unwrapped = graphQLResult.data {
          chatMessages = unwrapped.messages
          chatOpen = chatId ?? 0
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
    Network.shared.apollo.perform(mutation: SendMessageMutation(input: SendMessageInput( content: inputMessage, associationId: chatOpen, attachments: [] ))) { result in
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
    NavigationSplitView {
      List {
        ForEach(0..<chatsList.count, id: \.self) { result in
          Button(chatsList[result].recipient?.username ?? chatsList[result].name) {
            openChat(chatId: chatsList[result].association?.id)
          }
        }
      }
    } detail: {
      if chatOpen != 0 {
        ScrollViewReader { proxy in
          ScrollView {
            VStack(alignment: .leading, spacing: 6) {
              ForEach(chatMessages.reversed(), id: \.self) { message in
                HStack (alignment: .top, spacing: 6) {
                  if ((message.user?.avatar) != nil) {
                    AsyncImage(
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
                    Text(message.content ?? "Error")
                      .frame(minWidth: 0,
                             maxWidth: .infinity,
                             minHeight: 0,
                             maxHeight: .infinity,
                             alignment: .topLeading)
                  }
                }.padding(4)
                  .id(message.id)
              }
            }.frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
            .onAppear {
              if (chatMessages.count != 0) {
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
      } else {
        Text("Comms")
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
