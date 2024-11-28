import AVFoundation
import Combine

class RadioStream: ObservableObject {
    
    @Published var isPlaying = false
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
 

    init(url: String) {

        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        self.playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)

    }

    // Play the stream
    func play() {
        if playerItem.status == .readyToPlay {
            player.play()
            isPlaying = true
            //isBuffering = false
            print("Player is playing. rate: \(player.rate)")
        } else {
            print("Player is not ready to play yet.")
            // Optionally handle buffering or waiting state here
        }
    }

    // Pause the stream
    func pause() {
        player.pause()
        isPlaying = false
        //isBuffering = false
        print("Player is paused. rate: \(player.rate)")
    }

}
