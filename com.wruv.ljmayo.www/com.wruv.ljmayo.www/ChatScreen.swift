//
//  ChatScreen.swift
//  com.wruv.ljmayo.www
//
//  Created by user264313 on 10/20/24.
//

import SwiftUI

struct ChatScreen: View {
    @State private var newMessageText: String = ""
    @State var messages: [Message] = []
    var username: String
    
    var body: some View {
        List {
            ForEach(messages) { message in
                Text("\(message.sendingUser): \(message.text)")
            }
        }
        
        TextField("Enter a new message here...", text: $newMessageText)
            .onSubmit {
                var newMessage = Message(text: newMessageText, sendingUser: username, timeSent: Date())
                messages.append(newMessage)
            }
    }
}

#Preview {
    ChatScreen(username: "jsdrisco")
}
