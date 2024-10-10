//
//  RadioPlayerView.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/10/24.
//

import SwiftUI
import SwiftUICore

struct RadioPlayerView: View {
    
    @Binding var playing:Bool
    @Binding var showname:String
    @Binding var djName:String
    var body: some View {
        ZStack(){
            Rectangle().fill(.black).frame(height:90)
            HStack{
                Button(action: toggleButton){
                    SwiftUICore.ZStack{
                        Circle()
                            .fill(.white)
                            .frame(height: 60)
                        Circle()
                            .fill(.black)
                            .frame(height: 50)
                        if playing{
                            Image(systemName: "pause").foregroundColor(.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }else{
                            Image(systemName: "play").foregroundColor(.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }
                    }
                }
                HStack{
                    Text("\(showname)\n \(djName)").foregroundColor(.white).bold().font(.largeTitle)
                    
                }.padding()
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


