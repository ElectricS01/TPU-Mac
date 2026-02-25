//
//  ChatMessage.swift
//  TPU Mac
//
//  Created by ElectricS01  on 19/2/2026.
//

import MarkdownUI
import NukeUI
import PrivateUploaderAPI
import SDWebImageSwiftUI
import SwiftUI

struct ChatMessageView: View {
  let message: MessagesQuery.Data.Message
  let previousMessage: MessagesQuery.Data.Message?
  let chatOpen: Int
  let scrollProxy: ScrollViewProxy
  @FocusState.Binding var focusedField: FocusedField?
  let unread: Bool
  let onReplyClick: (Int) -> Void
  @Binding var editingId: Int
  let onInputClear: () -> Void
  @EnvironmentObject var store: Store
  @State private var editingMessage: String = ""
  @State private var hovered: Bool = false
  
  func editMessage() {
    Network.shared.apollo.perform(mutation: EditMessageMutation(input: EditMessageInput(content: GraphQLNullable<String>(stringLiteral: editingMessage), attachments: [], messageId: editingId, associationId: chatOpen))) { result in
      switch result {
      case .success:
        onInputClear()
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }
  
  func pinMessage(messageId: Int, pinned: Bool) {
    Network.shared.apollo.perform(mutation: EditMessageMutation(input: EditMessageInput(attachments: [], messageId: messageId, associationId: chatOpen, pinned: GraphQLNullable<Bool>(booleanLiteral: pinned)))) { result in
      switch result {
      case .success:
        onInputClear()
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }
  
  func deleteMessage(messageId: Int) {
    Network.shared.apollo.perform(mutation: DeleteMessageMutation(input: DeleteMessageInput(messageId: messageId, associationId: chatOpen))) { result in
      switch result {
      case .success:
        onInputClear()
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
  
  func renderMentions(
    _ text: String
  ) -> String {
    print(text)
    var result = text
    
    let regex = try! NSRegularExpression(pattern: #"<@(\d+)>"#)
    let matches = regex.matches(
      in: text,
      range: NSRange(text.startIndex..., in: text)
    )
    
    for match in matches.reversed() {
      guard
        let idRange = Range(match.range(at: 1), in: result),
        let fullRange = Range(match.range(at: 0), in: result)
      else { continue }
      
      let id = result[idRange]
      let username = store.coreUsers.unsafelyUnwrapped.first(where: { $0.id == Int(id) })?.username ?? "Unknown"
      
      result.replaceSubrange(
        fullRange,
        with: "[@\(username)](mention://\(id))"
      )
    }
    
    return result
  }

  var body: some View {
    let dontMerge = merge(message: message, previousMessage: previousMessage)
    if dontMerge {
      Spacer(minLength: 16)
    }
    if unread {
      HStack {
        VStack { Divider().background(.red) }
        Text("New Message").foregroundStyle(.red)
        VStack { Divider().background(.red) }
      }
    }
    if message.reply != nil {
      Button(action: {
        scrollProxy.scrollTo(message.replyId)
      }) {
        HStack {
          Image(systemName: "arrow.turn.up.right").frame(width: 16, height: 16)
          ProfilePicture(avatar: message.reply?.user?.avatar, size: 16)
          Text(message.reply?.user?.username ?? "User has been deleted")
          Text(renderMentions(message.reply?.content ?? "Message has been deleted").replacingOccurrences(of: "\n", with: "")).lineLimit(1)
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
            Text(DateUtils.dateFormat(message.createdAt)).foregroundColor(.secondary)
          }.frame(minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: 10,
                  alignment: .topLeading)
        }
        if editingId != message.id {
          Markdown(renderMentions(message.content ?? ""))
            .markdownSoftBreakMode(.lineBreak)
            .textSelection(.enabled)
            .markdownBlockStyle(\.blockquote) { configuration in
              configuration.label
                .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 2))
                .overlay(alignment: .leading) {
                  Rectangle().frame(width: 2)
                }
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .leading)
            .environment(\.openURL, OpenURLAction { url in
              if url.scheme == "mention" {
                let id = url.host ?? ""
                print("Clicked:", id)
                return .handled
              }
              
              return .systemAction
            })
          
        } else {
          TextField("Keep it civil!", text: $editingMessage)
            .focused($focusedField, equals: .editing)
#if !os(iOS)
            .onExitCommand(perform: {
              editingId = -1
              focusedField = .sending
            })
#endif
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
                    Text(line.text).font(.title2).lineLimit(1)
                  } else {
                    Text(line.text)
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
#if os(macOS)
      HStack {
        if hovered {
          Spacer()
          Button(action: {
            onReplyClick(message.id)
          }) {
            Image(systemName: "arrowshape.turn.up.left.fill").frame(width: 16, height: 16)
          }.buttonStyle(.borderless).frame(width: 20, height: 20)
          Button(action: {
            deleteMessage(messageId: message.id)
          }) {
            Image(systemName: "trash.fill").frame(width: 16, height: 16)
          }.buttonStyle(.borderless).frame(width: 20, height: 20)
          Button(action: {
            pinMessage(messageId: message.id, pinned: message.pinned)
          }) {
            Image(systemName: message.pinned ? "pin.slash.fill" : "pin.fill").frame(width: 16, height: 16)
          }.buttonStyle(.borderless).frame(width: 20, height: 20)
          if store.coreUser?.id == message.userId {
            Button(action: {
              if editingId != message.id {
                editingId = message.id
                editingMessage = message.content ?? ""
                focusedField = .editing
              } else {
                editingId = -1
                focusedField = .sending
              }
            }) {
              Image(systemName: "pencil").frame(width: 16, height: 16)
            }.buttonStyle(.borderless).frame(width: 20, height: 20)
          }
        }
      }.frame(width: 104, height: 20)
#endif
    }.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)).id(message.id)
      .contentShape(Rectangle())
      .contextMenu {
        if store.coreUser?.id == message.userId {
          Button {
            if editingId != message.id {
              editingId = message.id
              editingMessage = message.content ?? ""
              focusedField = .editing
            } else {
              editingId = -1
              focusedField = .sending
            }
          } label: {
            Label("Edit message", systemImage: "pencil")
          }
        }
        Button {
          onReplyClick(message.id)
        } label: {
          Label("Reply", systemImage: "arrowshape.turn.up.left.fill")
        }
        Button {
          copyToClipboard(message.content ?? "Message was deleted")
        } label: {
          Label("Copy Text", systemImage: "document.on.document")
        }
        Button {
          pinMessage(messageId: message.id, pinned: message.pinned)
        } label: {
          Label("Pin message", systemImage: message.pinned ? "pin.slash.fill" : "pin.fill")
        }
        Divider()
        Button {
          deleteMessage(messageId: message.id)
        } label: {
          Label("Delete Message", systemImage: "trash.fill").tint(.red)
        }
        Divider()
        Button {
          copyToClipboard(String(message.id))
        } label: {
          Label("Copy Message ID", systemImage: "person.text.rectangle")
        }
      }
      .background(Color(hovered ? Color.primary : .clear).opacity(0.1))
      .onHover { hover in
        hovered = hover
      }
  }
}
