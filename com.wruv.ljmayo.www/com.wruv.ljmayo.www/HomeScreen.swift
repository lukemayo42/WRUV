//
//  HomeScreen.swift
//  com.wruv.ljmayo.www
//
//  Created by Max Schwarz on 10/5/24..
//
import SwiftUI

struct HomeScreen: View {
    var body: some View {
        
        VStack {
            
            Image("wruvlogo")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            ScrollView {
                VStack {
                    HStack {
                        Image("SampleLogo1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        
                        Spacer()
                        Text("Peg - Steely Dan")
                    }
                    .padding()
                    HStack {
                        Image("SampleLogo2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        
                        Spacer()
                        Text("Turn to Stone - Electric Light Orchestra")
                    }
                    .padding()
                    HStack {
                        Image("SampleLogo2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        Spacer()
                        Text("Turn to Stone - Electric Light Orchestra")
                        
                    }
                    .padding()
                    HStack {
                        Image("SampleLogo1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        
                        Spacer()
                        Text("Peg - Steely Dan")
                    }
                    .padding()
                }
               
            }
        }
    }
}

#Preview {
    HomeView()
}
