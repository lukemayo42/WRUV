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
    let CHATHEIGHT = 800.00
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                List {
                    ForEach(messages) { message in
                        Text("\(message.sendingUser): \(message.text)")
                    }
                }
            }
            .frame(height: CHATHEIGHT)
        }
        .background(Color.white)
        
        TextField("Enter a new message here...", text: $newMessageText)
            .onSubmit {
                var newMessage = Message(text: newMessageText, sendingUser: username, timeSent: Date())
                messages.append(newMessage)
                newMessageText = ""
            }
            .frame(width: 350, alignment: .center)
    }
}

#Preview {
    ChatScreen(username: "jsdrisco")
}
