//
//  ArchivesScreen.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/5/24.
//

import SwiftUI

struct ArchivesScreen: View {
    @EnvironmentObject var style : UIStyles
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var spinitron: SpinitronValues
    //@State private var searchText  = ""
    

    //@State private var showText: String?
    var body: some View {
        NavigationStack {
            ZStack{
                if colorScheme == .dark{
                    style.black.ignoresSafeArea()
                } else{
                    style.white.ignoresSafeArea()
                }
                
                ScrollView{
                    ForEach(spinitron.filterPlaylists, id: \.self) { playlist in
                        ArchiveShowView(show: playlist)
                    }
                }
               
            }
            .navigationTitle("Archives")
        }.searchable(text: $spinitron.searchText, prompt:"search")
            .frame(maxHeight:.infinity, alignment:.bottom)    }
/*
    var searchResults: [PlaylistValues] {
        if searchText.isEmpty {
            return spinitron.playlistModel
        } else {
            return spinitron.playlistModel.showName.filter { $0.contains(searchText) }
        }
    }*/
}

#Preview {
    ArchivesScreen().environmentObject(UIStyles())
}
