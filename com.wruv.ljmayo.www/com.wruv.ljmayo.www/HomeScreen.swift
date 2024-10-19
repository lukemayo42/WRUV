//
//  HomeScreen.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/5/24..
//
import SwiftUI

struct HomeScreen: View {
    @State private var showPlaylist: Bool = false  // State to manage pop-up
    @State private var isPlaying: Bool = false
    var body: some View {
        
        VStack {
            
            Image("wruvlogo")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            Text("Upcoming Shows")
            ScrollView {
                VStack {
                    
                    Text("11/1 DJ: Example Show - Example Time")
                    .padding()
                    Text("11/2 DJ: Example Show - Example Time")
                    .padding()
                    Text("11/3 DJ: Example Show - Example Time")
                    .padding()
                    Text("11/4 DJ: Example Show - Example Time")
                    .padding()
                }
                
            }
            .fullScreenCover(isPresented: $isPlaying) {
                HomeView()
            }
            .sheet(isPresented: $showPlaylist) {
                PlaylistView(showPlaylist: $showPlaylist)
            }
           
        }
        VStack{
            Spacer()
            Button(action: { showPlaylist = true }) {
                HStack {
                    Image("SampleLogo1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                    Spacer()
                    Text("Peg - Steely Dan")
                }
                .padding()
            }
            
        }
        
    }
        
    
}



#Preview {
    HomeView()
}
