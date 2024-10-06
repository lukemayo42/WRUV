//
//  LoadingScreen.swift
//  com.wruv.ljmayo.www
//
// WRUV App logo flash loading screen shown on startup
//

import SwiftUI

struct LoadingScreen: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                // once our login/main screen are implemented this if can be altered
                ContentView()
            } else {
                Rectangle()
                    .background(Color.black)
                Image("wruvlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
            }
        }
        .onAppear {
            // fade out after a few seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

// struct for previewing screen
struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}

