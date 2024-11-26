//
//  RadioPlayerView.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/10/24.
//

import SwiftUI
import AVFoundation

struct RadioPlayerView: View {
    @EnvironmentObject var style : UIStyles
    //@EnvironmentObject var spinitron: SpinitronValues
    @EnvironmentObject var radioStream: RadioStream
    @Binding var playing:Bool
    @Binding var showname:String
    @Binding var djName:String
    
    var body: some View {
        ZStack{
            Rectangle().fill(style.black).frame(height:90)
            HStack{
                //Spacer()
                Button(action: toggleButton){
                   ZStack{
                        Circle()
                           .fill(style.white)
                            .frame(height: 60)
                        Circle()
                           .fill(style.darkGray)
                            .frame(height: 50)
                        if playing{
                            Image(systemName: "pause").foregroundColor(style.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }else{
                            Image(systemName: "play").foregroundColor(style.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }
                    }
                   .padding(.leading, 50)
                }
                Spacer()
                HStack{
//                    Text("\(spinitron.currShow.showName)\n \(spinitron.currShow.djName)").foregroundColor(.white).bold().font(style.primaryFont(size:24.0))
                    Text("Current Show\n Current DJ").foregroundColor(.white).bold().font(style.primaryFont(size:24.0))
                        .padding(.trailing, 30)
                    
                }
                
            }
            
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
    }
    func toggleButton(){
        if playing{
            playing = false
            radioStream.pause()
        }else{
            playing = true
            radioStream.play()
        }
    }
}


#Preview {
    var style = UIStyles()
    HomeView()
        .environmentObject(style)
        .environmentObject(RadioStream(url:"http://icecast.uvm.edu:8005/wruv_fm_128.m3u"))
    
}
