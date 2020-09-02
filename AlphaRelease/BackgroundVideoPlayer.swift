import AVFoundation
import UIKit

class BackgroundVideoPlayer {
    private var player = AVPlayer()

    func play(_ view: UIView) {
        guard let path = Bundle.main.path(forResource: "restaurant", ofType: "mp4") else {
            return
        }

        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        player.isMuted = true

        let layer = AVPlayerLayer(player: player)
        layer.frame = view.frame
        layer.opacity = 0.95
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.zPosition = -1
        view.layer.addSublayer(layer)

        player.play()

        NotificationCenter.default.addObserver(self, selector: #selector(loopVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private dynamic func loopVideo() {
        player.seek(to: kCMTimeZero)
        player.play()
    }
}

