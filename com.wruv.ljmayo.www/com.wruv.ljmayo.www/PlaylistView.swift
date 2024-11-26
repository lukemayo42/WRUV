//
//  PlaylistView.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/17/24.
//
import SwiftUI
struct PlaylistView: View {
    @EnvironmentObject var spinitron: SpinitronValues
    @Binding var showPlaylist: Bool

    var body: some View {
        NavigationView {
            VStack{
                //TODO: make title look nice
                //Text("Recent Spins").font(.largeTitle)
                List(spinitron.spins, id:\.id) { spin in
                    PlaylistRow(spin:spin)
                }.task{
                    await spinitron.refreshSpins()
                }.listStyle(.insetGrouped)
            }
               
        }
        .navigationTitle("Now Playing")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//TODO: make it look real nice
struct PlaylistRow: View{
    @EnvironmentObject var spinitron: SpinitronValues
    var spin :Spin
    init(spin: Spin){
        self.spin = spin
    }
    var body: some View{
        Section{
            //TODO: display time, need to format string
            //Text(spin.time)
            //Spacer()
            HStack{
                if spin.image == nil{
                    Image("wruvlogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                }else{
                    let imageURL = URL(string: spin.image!)
                    AsyncImage(url: imageURL, content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height:60)
                            .cornerRadius(10)
                        
                    }, placeholder: {
                        Image("wruvlogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        
                    })
                }
                VStack(alignment:.leading){
                    if spin.release != nil{
                        Text(spin.release!)
                    }
                    if spin.released != nil{
                        Text(String(spin.released!))
                    }
                }
            }
        }header:{
            Text("\(spin.song) - \(spin.artist)")
        }footer: {
            Text("\(spinitron.parseTime(time:spin.time))")
        }.headerProminence(.increased)

    }
}


#Preview {
    HomeView()
        .environmentObject(UIStyles())
        .environmentObject(SpinitronValues())
}

