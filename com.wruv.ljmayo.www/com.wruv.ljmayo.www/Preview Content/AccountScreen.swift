//
//  AccountScreen.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/5/24.
//
import SwiftUI

struct AccountScreen: View {
    var body: some View {
        VStack {
            Text("Account Screen")
                .font(.largeTitle)
                .padding()
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
