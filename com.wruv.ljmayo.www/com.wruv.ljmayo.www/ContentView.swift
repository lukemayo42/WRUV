//
//  ContentView.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 9/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var playing = false
    //placeholder values
    @State private var showname = "radio show"
    @State private var djName = "DJ"
    var body: some View {
        //could be a subview
        ZStack(){
            Rectangle().fill(.black).frame(height:110)
            HStack{
                
                Button(action: toggleButton){
                    ZStack{
                        Circle()
                            .fill(.white)
                            .frame(height: 70)
                        Circle()
                            .fill(.black)
                            .frame(height: 60)
                        if playing{
                            Image(systemName: "pause").foregroundColor(.white).font(.system(size: 35, weight: .bold, design: .rounded))
                        }else{
                            Image(systemName: "play").foregroundColor(.white).font(.system(size: 35, weight: .bold, design: .rounded))
                        }
                    }
                }
                HStack{
                    Text("\(showname)\n \(djName)").foregroundColor(.white).bold().font(.largeTitle)
                
                }.padding()
            }
           
        }
            
            TabView {
                HomeScreen()
                    .tabItem {
                        Image(systemName: "house.fill")
                        
                    }
                
                // Archives Screen Tab
                ArchivesScreen()
                    .tabItem {
                        Image(systemName: "line.3.horizontal")
                            .rotationEffect(.degrees(90))
                    }
                
                // Account Screen Tab
                AccountScreen()
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
            }
        }
    func toggleButton(){
        if playing{
            playing = false
        }else{
            playing = true
        }
    }
}


#Preview {
    ContentView()
}
