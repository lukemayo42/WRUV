//
//  Message.swift
//  com.wruv.ljmayo.www
//
//  Created by user264313 on 10/20/24.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    var text: String
    var sendingUser: String
    var timeSent: Date
}
