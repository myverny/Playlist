//
//  PlaylistTableViewCell.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 19..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlaylistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    private var videoId: String!
    private var vc: UIViewController!
    private var tapGestureRecognizer: UIGestureRecognizer?
    
    func setUp(videoId: String, vc: UIViewController) {
        self.videoId = videoId
        self.vc = vc
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchCell))
        addGestureRecognizer(tapGestureRecognizer!)
        
        HttpConn.getVideoInfo(for: videoId) { (result) in
            switch result {
            case .success(let videos):
                self.titleLabel.text = videos[0].snippet.title
                let viewCount = Int(videos[0].statistics.viewCount) ?? 0
                self.viewCountLabel.text = "\(viewCount.toAbbr()) Views"
            
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
        
        if let url = URL(string: String(format: "https://img.youtube.com/vi/%@/hqdefault.jpg", videoId)) {
            // ytpView.load(withVideoId: videoId)
            DispatchQueue.global().async() {
                let imageData = try? Data(contentsOf: url)
                DispatchQueue.main.async() { [weak self] in
                    if imageData != nil, let image = UIImage(data: imageData!) {
                        self?.thumbnailImageView?.image = image
                    }
                }
            }
        }
    }
    
    @objc
    func touchCell() {
        let storyboard = UIStoryboard(name: "VideoPlay", bundle: nil)
        if let pvc = storyboard.instantiateInitialViewController() as? VideoPlayViewController {
            pvc.videoId = videoId
            vc.show(pvc, sender: self)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let tgr = tapGestureRecognizer {
            removeGestureRecognizer(tgr)
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
