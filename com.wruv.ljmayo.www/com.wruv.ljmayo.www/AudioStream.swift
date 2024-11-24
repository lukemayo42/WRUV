//
//  RadioStream.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/27/24.
//

import Foundation
import AVFoundation

class AudioStream:ObservableObject{
    var isPlaying = false
    var player = AVPlayer()
    //var playerItem: AVPlayerItem!
    var name: String
    var url : String
    init(url: String, name: String){
        self.name = name
        self.url = url
        initializeAudio()
    }
    func play(){
        isPlaying = true
        player.play()
    }
    func pause(){
        isPlaying = false
        player.pause()
    }
    
    func initializeAudio(){
        guard let url  = URL.init(string: url) else { return }
        let playerItem = AVPlayerItem(url:url)
        self.player = AVPlayer.init(playerItem: playerItem)
    }
}
