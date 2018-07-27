//
//  VideoPlayViewController.swift
//  Playlist
//
//  Created by dev on 2018. 7. 23..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoPlayViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var playView: YTPlayerView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var playControlButton: UIButton!
    
    var videoId: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        playView.load(withVideoId: videoId, playerVars: [
            "origin":"http://www.youtube.com",
            "playsinline": 1,
            "showinfo": 0,
            "controls": 0,
            "cc_load_policy": 1,
            "autohide": 1,
            "autoplay": 1,
            "modestbranding": 1])
        playView.delegate = self
        playView.bringSubview(toFront: playControlButton)
        playControlButton.alpha = 0.02
    }
    
    // auto play
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        let progress = playTime / Float(self.playView.duration())
        slider.value = progress
    }
    
    @IBAction func onSliderChange(_ sender: Any) {
        let seekToTime = Float(self.playView.duration()) * self.slider.value
        playView.seek(toSeconds: seekToTime, allowSeekAhead: true)
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .playing:
            playControlButton.alpha = 0.02
        case .paused:
            playControlButton.alpha = 1.0
        default:
            return
        }
    }
    
    @IBAction func onPlayControlButtonTouched(_ sender: Any) {
        switch playView.playerState() {
        case YTPlayerState.playing:
            playView.pauseVideo()
        case .paused:
            playView.playVideo()
        default:
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
