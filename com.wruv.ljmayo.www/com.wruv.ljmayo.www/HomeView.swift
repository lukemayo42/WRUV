//
//  ContentView.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 9/26/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var style: UIStyles
    @EnvironmentObject var spintron: SpinitronValues
    @EnvironmentObject var radioStream: RadioStream
    @EnvironmentObject var authService: FirebaseAuthService
    @Environment(\.colorScheme) var colorScheme
    @State var radioPlaying: Bool =  false
    @State private var showname: String = "radio show"
    @State private var djName: String = "DJ"
    @State var archivesPlaying:Bool = false
    
    var body: some View {
        TabView {
            // Home Screen Tab
            tabGroup(view: HomeScreen())
                .tabItem {
                    Image(systemName: "music.house.fill")
                        .renderingMode(.template)
                        .foregroundColor(style.white)
                    Text("Home")
                }
            //Chat Screen Tab
            tabGroup(view: ChatScreen(username: "WRUVguy")) 
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Chat")
                }
            // Archives Screen Tab
            tabGroup(view: ArchivesScreen(archivesPlaying: $archivesPlaying, radioPlaying:$radioPlaying))
                .tabItem {
                    Image(systemName: "archivebox.fill")
                    Text("Archives")
                }
            // Account Screen Tab
            tabGroup(view: AccountScreen())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
        }
    }
    

    func tabGroup(view: some View) -> some View {
        VStack {
            view
            RadioPlayerView(radioPlaying:$radioPlaying, showname:$showname, djName:$djName, archivesPlaying: $archivesPlaying)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(colorScheme == .dark ? style.black : style.white)
    }
}

#Preview {
    var style = UIStyles()
    HomeView().environmentObject(UIStyles())
}

