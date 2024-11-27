//
//  RadioPlayerView.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/10/24.
//

import SwiftUI

struct ArchiveShowView: View {
    @EnvironmentObject var style : UIStyles
    @EnvironmentObject var radioStream: RadioStream
    @Binding var archivesPlaying:Bool
    @Binding var radioPlaying:Bool
    @Binding var currShow: PlaylistValues?
    @State private var archiveStream: RadioStream
    private var showName: String
    private var djName: String
    private var archivesLink: String
    private var show: PlaylistValues
    @State private var playingLocal: Bool = false
    init(show: PlaylistValues, archivesPlaying: Binding<Bool>,  currShow:  Binding<PlaylistValues?>, radioPlaying: Binding<Bool>){
        showName = show.showName
        djName = show.djName
        archivesLink = show.archivesLink
        archiveStream = RadioStream(url:archivesLink)
        self._archivesPlaying = archivesPlaying
        self._currShow = currShow
        self._radioPlaying = radioPlaying
        self.show = show
    }

    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius:12)
                .fill(style.white)
                .frame(height:80)
                .padding(EdgeInsets(top:0, leading: 20, bottom:0, trailing:20))
            
            RoundedRectangle(cornerRadius:12)
                .fill(style.black)
                .frame(height:70)
                .padding(EdgeInsets(top:0, leading: 25, bottom:0, trailing:25))
            
            HStack{
                Button(action: toggleButton){
                   ZStack{
                        Circle()
                           .fill(style.white)
                            .frame(height: 48)
                        Circle()
                           .fill(style.darkGray)
                            .frame(height: 40)
                        if playingLocal{
                            Image(systemName: "pause").foregroundColor(style.white).font(.system(size: 25.6, weight: .bold, design: .rounded))

                        }else{
                            Image(systemName: "play").foregroundColor(style.white).font(.system(size: 25.6, weight: .bold, design: .rounded))
                        }
                    }


                   
                    
                }.disabled(disableButtons())
                Spacer()
                HStack{
                    Text("\(showName)\n \(djName)").foregroundColor(style.white).font(style.primaryFont(size:24.0))

                        .frame(height: 70)
                        .truncationMode(.tail)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }.padding()

                Spacer()

            }
            .padding(.leading, 45.5)
        }
    }
    func toggleButton(){
        if playingLocal{
            currShow = nil
            archivesPlaying = false
            self.playingLocal = false
            archiveStream.pause()
        }else{
            currShow = show
            archivesPlaying = true
            self.playingLocal = true
            archiveStream.play()
        }
    }
    func disableButtons()->Bool{
        //disable all the buttons if the radio is playing
        if radioPlaying{
            return true
        }
        //disable all other buttons except for the current archive show thats playing
        if (currShow != nil){
            if currShow!.showName == show.showName{
                return false
            }
            return true
        }
        return false
    }
}



