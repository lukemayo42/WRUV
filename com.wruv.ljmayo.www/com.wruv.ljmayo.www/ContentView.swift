//
//  ContentView.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 9/26/24.
//

import SwiftUI

struct ContentView: View {
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

struct HomeScreen: View {
    var body: some View {
        VStack {
            Text("Home Screen")
                .font(.largeTitle)
                .padding()
            Image(systemName: "house.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}

struct ArchivesScreen: View {
    var body: some View {
        VStack {
            Text("Archives Screen")
                .font(.largeTitle)
                .padding()
            Image(systemName: "line.3.horizontal")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}

struct AccountScreen: View {
    var body: some View {
        VStack {
            Text("Account Screen")
                .font(.largeTitle)
                .padding()
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
