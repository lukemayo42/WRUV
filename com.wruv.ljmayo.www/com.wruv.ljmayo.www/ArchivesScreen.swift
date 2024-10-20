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
    @State private var searchText  = ""
    @State private var showList = ["askdhfkshdlkhas", "show 2", "show 3", "show 4", "show 5", "6", "7"]
    @State private var showText: String?
    var body: some View {
        NavigationStack {
            ZStack{
                if colorScheme == .dark{
                    style.black.ignoresSafeArea()
                } else{
                    style.white.ignoresSafeArea()
                }
                
                ScrollView{
                    ForEach(searchResults, id: \.self) { name in
                        ArchiveShowView(showname:name, djName:"DJ")
                    }
                }
               
            }
            .navigationTitle("Archives")
        }.searchable(text: $searchText, prompt:"search")
            .frame(maxHeight:.infinity, alignment:.bottom)    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return showList
        } else {
            return showList.filter { $0.contains(searchText) }
        }
    }
}

#Preview {
    ArchivesScreen().environmentObject(UIStyles())
}
