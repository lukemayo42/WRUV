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
    @Binding var playing:Bool
    @Binding var currShow: PlaylistValues?
    //@State private var archiveStream: RadioStream
    private var showName: String
    private var djName: String
    private var archivesLink: String
    private var show: PlaylistValues
    @State private var playingLocal: Bool = false
    init(show: PlaylistValues, playing: Binding<Bool>,  currShow:  Binding<PlaylistValues?>){
        showName = show.showName
        djName = show.djName
        archivesLink = show.archivesLink
        //archiveStream = RadioStream(url:archivesLink)
        self._playing = playing
        self._currShow = currShow
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
                            .frame(height: 60)
                        Circle()
                           .fill(style.darkGray)
                            .frame(height: 50)
                        if playingLocal{
                            Image(systemName: "pause").foregroundColor(style.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }else{
                            Image(systemName: "play").foregroundColor(style.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }
                    }
                }.disabled(disableButtons())
                HStack{
                    Text("\(showName)\n \(djName)").foregroundColor(style.white).bold().font(style.primaryFont(size:24.0))
                        .frame(height: 70)
                        .truncationMode(.tail)
                }.padding()
                    
            }
        }
    }
    func toggleButton(){
        if playingLocal{
            currShow = nil
            playing = false
            self.playingLocal = false
        }else{
            currShow = show
            playing = true
            self.playingLocal = true
        }
    }
    func disableButtons()->Bool{
        if (currShow != nil){
            //print(show.showName)
            //print(currShow!.showName)
            if currShow!.showName == show.showName{
                print("woohoo")
                return false
            }
            return true
        }
        return false
    }
}


#Preview {
    ArchivesScreen().environmentObject(UIStyles())
}
