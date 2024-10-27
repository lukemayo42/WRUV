//
//  ContentView.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 9/26/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var style: UIStyles
    @EnvironmentObject var radioStream: RadioStream
    @Environment(\.colorScheme) var colorScheme
    @State private var playing: Bool =  false
    //placeholder values
    @State private var showname: String = "radio show"
    @State private var djName: String = "DJ"
    var body: some View {
        TabView {
            tabGroup(view: HomeScreen())
                .tabItem {
                    Image(systemName: "music.house.fill")
                        .renderingMode(.template)
                        .foregroundColor(style.white)
                    Text("Home")
                    
                }
            
            tabGroup(view: ArchivesScreen())
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

    func tabGroup(view: some View) -> some View{
        VStack{
            view

            RadioPlayerView(playing:$playing, showname:$showname, djName:$djName)//.frame(maxHeight:.infinity, alignment:.bottom)
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity, alignment: .bottom)
        .background(colorScheme == .dark ? style.black : style.white)

    }
}



#Preview {
    var style = UIStyles()
    HomeView().environmentObject(UIStyles())
}
