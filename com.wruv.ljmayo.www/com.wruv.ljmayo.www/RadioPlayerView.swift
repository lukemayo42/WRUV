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
    @EnvironmentObject var spinitron: SpinitronValues
    @EnvironmentObject var radioStream: AudioStream
    @EnvironmentObject var archivesStream: AudioStream
    @Binding var radioPlaying:Bool
    @Binding var showname:String
    @Binding var djName:String
    @Binding var archivesPlaying: Bool
    
    var body: some View {
        ZStack{
            Rectangle().fill(style.black).frame(height:90)
            HStack{
                HStack{
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .padding(.leading, 10)
                    Text("Live").foregroundColor(.white)
                        //.padding(.leading, 10)
                }
                Spacer()
                Button(action: toggleButton){
                   ZStack{
                        Circle()
                           .fill(style.white)
                            .frame(height: 60)
                        Circle()
                           .fill(style.darkGray)
                            .frame(height: 50)
                       if radioStream.isPlaying{
                            Image(systemName: "pause").foregroundColor(style.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }else{
                            Image(systemName: "play").foregroundColor(style.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }
                    }
                   .padding(.leading, 10)
                }
                Spacer()
                HStack{
                    Text("\(spinitron.currShow.showName)\n \(spinitron.currShow.djName)").foregroundColor(.white).bold().font(style.primaryFont(size:24.0))
                }
                
            }
            
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
    }
    func toggleButton(){
        if radioStream.isPlaying{
            radioStream.isPlaying = false
            radioStream.pause()
        }else{
            //if the archives are playing stop the archives stream and start the radioStream
            if archivesStream.isPlaying{
                archivesStream.pause()
                radioStream.isPlaying = true
                radioStream.play()
            }else{
                radioStream.isPlaying = true
                radioStream.play()
            }
            
        }
    }
}


#Preview {
    var style = UIStyles()
    HomeView()
        .environmentObject(style)
        //.environmentObject(AudioStream(url:"http://icecast.uvm.edu:8005/wruv_fm_128.m3u"))
    
}
