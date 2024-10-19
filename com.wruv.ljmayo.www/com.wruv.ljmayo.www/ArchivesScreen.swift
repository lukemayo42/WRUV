//
//  ArchivesScreen.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/5/24.
//

import SwiftUI

struct ArchivesScreen: View {
    @EnvironmentObject var style : UIStyles
    @State private var searchText  = ""
    @State private var showList = ["show 1", "show 2", "show 3", "show 4", "show 5", "6", "7"]
    @State private var showText: String?
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    Text(name)
                }
            }
            .navigationTitle("Archives")
        }.searchable(text: $searchText, prompt:"search")
            .background(style.black)
    }

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
