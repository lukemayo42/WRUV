//
//  com_wruv_ljmayo_wwwApp.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 9/26/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct com_wruv_ljmayo_wwwApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authService = FirebaseAuthService()
    
    var style = UIStyles()
    var spinitron = SpinitronValues()

    var radioStream = RadioStream(url:"http://icecast.uvm.edu:8005/wruv_fm_128")
    var body: some Scene {
        
        WindowGroup {
            // loading screen appears first
            LoadingScreen()
                .environmentObject(style)

                .environmentObject(spinitron)

                .environmentObject(radioStream)
                .environmentObject(authService)

        }
    }
}
