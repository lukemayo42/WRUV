//
//  RadioPlayerView.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/10/24.
//

import SwiftUI

struct ArchiveShowView: View {
    @EnvironmentObject var style : UIStyles
    @EnvironmentObject var radioStream: AudioStream
    @EnvironmentObject var archivesStream: AudioStream
    //Binding var archivesPlaying:Bool
    //@Binding var radioPlaying: Bool
    //private var showname:String
    //private var djName:String
    private var archivedShow: PlaylistValues
    init(show: PlaylistValues){
        self.archivedShow = show
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
                            .frame(height: 60)
                        Circle()
                           .fill(style.darkGray)
                            .frame(height: 50)
                       if archivesStream.isPlaying{
                            Image(systemName: "pause").foregroundColor(style.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }else{
                            Image(systemName: "play").foregroundColor(style.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }
                    }
                }
                HStack{
                    Text("\(archivedShow.showName)\n \(archivedShow.djName)").foregroundColor(style.white).bold().font(style.primaryFont(size:24.0))
                        .frame(height: 70)
                        .truncationMode(.tail)
                }.padding()
            }
        }
    }
    func toggleButton(){
        //if {
            
        
        /*
        if archivesStream.isPlaying{
            //archivesPlaying = false
            archivesStream.pause()
        }else{
            //if another archived show is playing the
            //check what the archiveShow stream url is
            if archivesStream.url == archivedShow.archivesLink{
                //check if the radiostream is playing
                if radioStream.isPlaying{
                    //radioPlaying = false
                    radioStream.pause()
                }
                //archivesPlaying = true
                archivesStream.play()
            }else{
                archivesStream.pause()
                //initialize the ArchivesStream with the correct link
                archivesStream.url = "https://www.uvm.edu/~wruv/res/thisweek/\(archivedShow.archivesLink)"
                archivesStream.initializeAudio()
                archivesStream.play()
                //archivesPlaying = true
                }
            
        }
         */
    }
}


#Preview {
    ArchivesScreen().environmentObject(UIStyles())
}
