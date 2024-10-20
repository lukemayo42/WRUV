//
//  RadioPlayerView.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/10/24.
//

import SwiftUI

struct ArchiveShowView: View {
    @EnvironmentObject var style : UIStyles
    @State private var playing:Bool = false
    private var showname:String
    private var djName:String
    init(showname:String, djName:String){
        self.showname = showname
        self.djName = djName
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
                        if playing{
                            Image(systemName: "pause").foregroundColor(style.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }else{
                            Image(systemName: "play").foregroundColor(style.white).font(.system(size: 32, weight: .bold, design: .rounded))
                        }
                    }
                }
                HStack{
                    Text("\(showname)\n \(djName)").foregroundColor(style.white).bold().font(style.primaryFont(size:24.0))
                        .frame(height: 70)
                        .truncationMode(.tail)
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


#Preview {
    ArchivesScreen().environmentObject(UIStyles())
}
