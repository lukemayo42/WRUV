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
    @State var queryTime = Date()
    var username: String
    let CHATHEIGHT = 800.00
    let chats = Firestore.firestore()
        
    // Post a message
    func post(message: Message) {
        do {
            chats.collection("Messages").document(message.id.uuidString).setData([
                "message": message.text,
                "timeSent": message.timeSent,
                "user": message.sendingUser
            ])
            print("Message sent")
        }
    }
    
    // Pull messages from the last time it was queried into messages list.
    func pull() async {
        do {
            let messageQuery = try await chats.collection("Messages").whereField("timeSent", isGreaterThan: queryTime).getDocuments()
            print("Gathered documents.")
            
            for message in messageQuery.documents {
                var text = message["message"] as! String
                var time = message["timeSent"] as! Firebase.Timestamp
                var date = time.dateValue()
                var user = message["user"] as! String
                print(text, " ", date, " ", user)
                messages.append(Message(text: text, sendingUser: user, timeSent: date))
            }
        } catch {
            print("Error getting documents.")
        }
        queryTime = Date()
    }
    
    var body: some View {
        // On a timer, pull new messages. Commented to limit requests while developing.
        /*let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            Task {
                await pull()
            }
        }*/
        
        VStack {
            Text("Live DJ Chat").font(.custom("Courier", size: 40))
            
            ScrollView {
                VStack(alignment: .leading) {
                    List {
                        ForEach(messages) { message in
                            Text("\(message.sendingUser): \(message.text)")
                                .listRowSeparator(.hidden)
                                .font(.custom("Courier", size: 18))
                        }
                    }
                    .listStyle(.inset)
                    .frame(height: CHATHEIGHT)
                }
            }
            
            // On post: pull immediately, so that user sees their message appear.
            TextField("Enter a new message here...", text: $newMessageText)
                .onSubmit {
                    var newMessage = Message(text: newMessageText, sendingUser: username, timeSent: Date())
                    post(message: newMessage)
                    newMessageText = ""
                    Task {
                        await pull()
                    }
                }
                .frame(width: 350, alignment: .center)
                .font(.custom("Courier", size: 20))
        }
    }
}

#Preview {
    ChatScreen(username: "jsdrisco")
}
