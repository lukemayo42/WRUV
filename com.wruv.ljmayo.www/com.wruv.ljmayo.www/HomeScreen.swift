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
    
    
    var body: some View {
        VStack {
            Image("wruvlogo")

                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            Text("Upcoming Shows").font(.largeTitle)
            ScrollView {
                Text("Today").bold()
                ForEach(spinitron.shows.today, id: \.id ){ show in
                    HStack{
                        Text(spinitron.parseTime(time:show.start)).padding()
                        Spacer()
                        Text("\(show.showName) - \(show.djName)")
                            .lineLimit(2) // Limit lines
                            .multilineTextAlignment(.center) // Center align text
                        Spacer()
                    }
                    
                }
                Text("Tomorrow").bold()
                ForEach(spinitron.shows.tomorrow, id: \.id ){ show in
                    HStack{
                        Text(spinitron.parseTime(time:show.start)).padding()
                        Spacer()
                        Text("\(show.showName) - \(show.djName)")
                            .lineLimit(2) // Limit lines
                            .multilineTextAlignment(.center) // Center align text
                        Spacer()
                    }
                }
            }
            .fullScreenCover(isPresented: $isPlaying) {
                HomeView()
            }
            .sheet(isPresented: $showPlaylist) {
                PlaylistView(showPlaylist: $showPlaylist)
            }
        }.onAppear{
            //call api every 12 minutes
            spinitron.startRepeatedFetch(query:spinitron.refreshShows, seconds: 720)
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
                                .padding(5)
                            
                        }, placeholder: {
                            Image("wruvlogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                                .padding(5)
                            
                        })
                    }else{
                        Image("wruvlogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                            .padding(5)
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
            //call api every 20 seconds
            spinitron.startRepeatedFetch(query:spinitron.refreshSpins, seconds: 20)
            
        }
    }
}



#Preview {
    HomeView().environmentObject(UIStyles())
        .environmentObject(SpinitronValues())
}
