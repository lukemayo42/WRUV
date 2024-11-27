import AVFoundation
import Combine

class RadioStream: /*NSObject,*/ ObservableObject {

    @Published var isPlaying = false
    //@Published var isBuffering = false // Track buffering state
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    /*
    override init() {
        super.init()  // Call superclass initializer
    }*/

    init(url: String) {
       /* super.init()  // Ensure superclass initializer is called*/

        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        self.playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
        /*
        // Observe the player's status and player item status for changes
        self.playerItem.addObserver(self, forKeyPath: "status", options: [.new], context: nil)
        self.playerItem.addObserver(self, forKeyPath: "error", options: [.new], context: nil)
        
        // Observe the player's rate (playback state)
        self.player.addObserver(self, forKeyPath: "rate", options: [.new], context: nil)

        // Optionally observe loaded time ranges (for buffering)
        self.playerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: [.new], context: nil)
         */
        //print("Initialized with URL: \(url)")
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
/*
    // Handle KVO for status, rate, error, and buffering
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            switch playerItem.status {
            case .unknown:
                print("Player Item status is unknown. Waiting for the media to load.")
                isBuffering = true
            case .readyToPlay:
                print("Player Item is ready to play.")
                // You can now safely call play
                if isPlaying {
                    player.play()
                }
                isBuffering = false
            case .failed:
                print("Player Item failed to load.")
                if let error = playerItem.error {
                    print("Error: \(error.localizedDescription)")
                }
                isBuffering = false
            @unknown default:
                print("Unknown player item status.")
                isBuffering = false
            }
        }

        if keyPath == "rate" {
            if player.rate > 0 {
                isPlaying = true
                print("Player is playing at rate: \(player.rate)")
            } else {
                isPlaying = false
                print("Player is paused or stopped.")
            }
        }

        if keyPath == "loadedTimeRanges" {
            // Check the buffer progress
            if let timeRanges = playerItem.loadedTimeRanges.first {
                let bufferedDuration = CMTimeGetSeconds(timeRanges.timeRangeValue.start) + CMTimeGetSeconds(timeRanges.timeRangeValue.duration)
                let totalDuration = CMTimeGetSeconds(playerItem.duration)
                print("Buffered: \(bufferedDuration) / \(totalDuration) seconds")
                
                // If the buffered content is greater than a threshold, mark it as ready to play
                if bufferedDuration >= totalDuration * 0.1 { // Example: 10% buffered
                    isBuffering = false
                    print("Sufficient buffer. Ready to play.")
                } else {
                    isBuffering = true
                    print("Buffering...")
                }
            }
        }

        if keyPath == "error" {
            if let error = playerItem.error {
                print("Error in player item: \(error.localizedDescription)")
            }
        }
    }

    // Remove observers when the object is deinitialized
    deinit {
        playerItem.removeObserver(self, forKeyPath: "status")
        playerItem.removeObserver(self, forKeyPath: "error")
        player.removeObserver(self, forKeyPath: "rate")
        playerItem.removeObserver(self, forKeyPath: "loadedTimeRanges")
    }*/
}
