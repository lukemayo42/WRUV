//
//  HomeScreen.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/5/24..
//
import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var spinitron: SpinitronValues
    @State private var showPlaylist: Bool = false  // State to manage pop-up
    @State private var isPlaying: Bool = false
    @State private var state = 0
    var spin  =  "hello"
    
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
            //Spacer()
            Button(action: { showPlaylist = true }) {
                HStack {
                    if spinitron.spins[0].image != nil{
                        let imageURL = URL(string: spinitron.spins[0].image!)
                        AsyncImage(url: imageURL, content: { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            
                        }, placeholder: {
                            Image("wruvlogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            
                        })
                    }else{
                        Image("wruvlogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                    }

                    Spacer()
                    Text(spinitron.getFirstSpin())
                            .padding()
       
                }
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                //.frame(width: .infinity, height: .infinity, alignment: .bottom)
            }
            
        }
        .onAppear{
            spinitron.startRepeatedFetch(query:spinitron.refreshSpins)
            
        }
    }
}



#Preview {
    HomeView().environmentObject(UIStyles())
        .environmentObject(SpinitronValues())
}
