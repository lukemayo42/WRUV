//
//  RadioStream.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/27/24.
//

import Foundation
import AVFoundation

class RadioStream:ObservableObject{
    var isPlaying = false
    var player = AVPlayer()
    var playerItem: AVPlayerItem!
    
    init(url: String){
        guard let url  = URL.init(string: url) else { return }
        let playerItem = AVPlayerItem(url:url)
        player = AVPlayer.init(playerItem: playerItem)
    }
    func play(){
        isPlaying = true
        player.play()
    }
    func pause(){
        isPlaying = false
        player.pause()
    }
}
