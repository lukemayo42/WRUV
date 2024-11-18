//
//  ChatScreen.swift
//  com.wruv.ljmayo.www
//
//  Created by jsdrisco on 10/20/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct ChatScreen: View {
    @State private var newMessageText: String = ""
    @State var messages: [Message] = []
    var username: String
    let CHATHEIGHT = 800.00
    let chats = Firestore.firestore()
    
    func post(message: Message) async {
        do {
            try await chats.collection("Messages").document(message.id.uuidString).setData([
                "message": message.text,
                "timeSent": message.timeSent,
                "user": message.sendingUser
            ])
            print("Message sent")
        } catch {
            print("Message not sent")
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    List {
                        ForEach(messages) { message in
                            Text("\(message.sendingUser): \(message.text)")
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.gray)
                        }
                    }
                    .listStyle(.inset)
                    .background(Color.gray)
                    .frame(height: min(CHATHEIGHT, 44.0 * Double(messages.count)))
                }
            }
            .background(Color.gray)
            
            TextField("Enter a new message here...", text: $newMessageText)
                .onSubmit {
                    var newMessage = Message(text: newMessageText, sendingUser: username, timeSent: Date())
                    messages.append(newMessage)
                    newMessageText = ""
                    
                    
                }
                .frame(width: 350, alignment: .center)
        }
        .background(Color.gray)
    }
}

#Preview {
    ChatScreen(username: "jsdrisco")
}
