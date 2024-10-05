//
//  ArchivesScreen.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/5/24.
//
struct ArchivesScreen: View {
    var body: some View {
        VStack {
            Text("Archives Screen")
                .font(.largeTitle)
                .padding()
            Image(systemName: "line.3.horizontal")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}
