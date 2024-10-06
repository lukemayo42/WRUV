//
//  ContentView.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 9/26/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            // Home Screen Tab
            HomeScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                    
                }
            
            // Archives Screen Tab
            ArchivesScreen()
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                        .rotationEffect(.degrees(90))
                }
            
            // Account Screen Tab
            AccountScreen()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
    }
}


#Preview {
    HomeView()
}
