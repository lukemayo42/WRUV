//
//  com_wruv_ljmayo_wwwApp.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 9/26/24.
//

import SwiftUI

@main
struct com_wruv_ljmayo_wwwApp: App {
    var style = UIStyles()
    var radioStream = RadioStream(url:"http://icecast.uvm.edu:8005/wruv_fm_128.m3u")
    var body: some Scene {
        WindowGroup {
            // loading screen appears first
            LoadingScreen()
                .environmentObject(style)
                .environmentObject(radioStream)
                
        }
    }
}
