//
//  PlaylistView.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/17/24.
//
import SwiftUI
struct PlaylistView: View {
    @Binding var showPlaylist: Bool

    var body: some View {
        NavigationView {
            VStack {
                Text("Playlist")
                  
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
                HStack {
                    Image("SampleLogo2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                    
                    Spacer()
                    Text("Turn to Stone - Electric Light Orchestra")
                }
                .padding()
                HStack {
                    Image("SampleLogo2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                    Spacer()
                    Text("Turn to Stone - Electric Light Orchestra")
                    
                }
                .padding()
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
                
                Spacer()
        }
        .navigationTitle("Now Playing")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    HomeView()
}

