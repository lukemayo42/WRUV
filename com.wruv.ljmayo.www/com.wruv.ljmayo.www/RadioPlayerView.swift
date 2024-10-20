//
//  RadioPlayerView.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/10/24.
//

import SwiftUI

struct RadioPlayerView: View {
    @EnvironmentObject var style : UIStyles
    @Binding var playing:Bool
    @Binding var showname:String
    @Binding var djName:String

    var body: some View {
        ZStack{
            Rectangle().fill(style.black).frame(height:90)
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
                    Text("\(showname)\n \(djName)").foregroundColor(.white).bold().font(style.primaryFont(size:32.0))
                }
            }
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
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
    var style = UIStyles()
    HomeView().environmentObject(style)
}
