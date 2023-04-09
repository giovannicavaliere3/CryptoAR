//
//  vdBack.swift
//  CT_AR
//
//  Created by Giovanni Cavaliere on 25/09/22.
//

import AVKit
import SwiftUI

class UIVideoPlayer: UIView {
    
    var playerLayer = AVPlayerLayer()
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    override init(frame: CGRect) {
            super.init(frame: frame)
            
           guard let url = URL(string: "https://github.com/Gionny200597/video/blob/749c9eaa4579ce1c1e541d55fc8fec3e876dfedf/bgVideo.mp4?raw=true") else { return }
        
    
        let player = AVPlayer(url: url)
                player.isMuted = true
                player.play()
              
                playerLayer.player = player
                playerLayer.videoGravity = AVLayerVideoGravity(rawValue: AVLayerVideoGravity.resizeAspectFill.rawValue)
        layer.addSublayer(playerLayer)
}
    
    override func layoutSubviews() {
            super.layoutSubviews()
            playerLayer.frame = bounds
        }
}
/*
class ViewController: UIViewController {

   
   
 
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var videoLayer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
        
    }
    
    func playVideo() {
        guard let path = Bundle.main.path(forResource: "bgVideo", ofType: "mp4") else {
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoLayer.layer.addSublayer(playerLayer)
        
        player.play()
        
        videoLayer.bringSubviewToFront(img)
        videoLayer.bringSubviewToFront(lbl)
    }


}
*/
