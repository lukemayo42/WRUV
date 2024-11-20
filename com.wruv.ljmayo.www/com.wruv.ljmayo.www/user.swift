//
//  user.swift
//  com.wruv.ljmayo.www
//
//  Created by user249214 on 11/7/24.
//
class User {
    var email: String
    var password: String
    var chatName: String
    
    init(email: String, password: String = "", chatName: String? = nil) {
        self.email = email
        self.password = password
        // set chatName as the part before "@" in the email by default
        self.chatName = chatName ?? email.split(separator: "@").first.map(String.init) ?? email
    }
}


