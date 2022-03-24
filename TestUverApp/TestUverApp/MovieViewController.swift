

import UIKit
import AVFoundation

class MovieViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //起動時に動画を再生
        let path = Bundle.main.path(forResource: "DownloadVideo", ofType: "mp4")!
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        player.play()
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(playerLayer, at: 0)
        
        nextViewTransition()
        
    }
    
    //動画終了後に次の画面に遷移
    func nextViewTransition() {
        
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        guard let nextViewValue = storyboard.instantiateInitialViewController() as? ViewController else {return}
        present(nextViewValue, animated: true)
        
    }
    
}
