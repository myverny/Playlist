//
//  RankCollectionViewCell.swift
//  Playlist
//
//  Created by dev on 2018. 7. 17..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class PlaylistsCollectionViewCell: UICollectionViewCell {
    static var frameHeight = CGFloat(74)
    
    private var hideRank: Bool = false {
        didSet {
            rankLabel.isHidden = hideRank
        }
    }
    private var videos = [String]()
    private var tapGestureRecognizer: UIGestureRecognizer?
    weak var vc: UIViewController!

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func setUp(hideRank: Bool, rank: String?, title: String, desc: String, imgUrl: URL, videos: [String], vc: UIViewController) {
        self.hideRank = hideRank
        if (!hideRank) {
            rankLabel.text = rank
        }
        titleLabel.text = title
        descLabel.text = desc
        DispatchQueue.global().async() {
            let imageData = try? Data(contentsOf: imgUrl)
            DispatchQueue.main.async() { [weak self] in
                if imageData != nil, let image = UIImage(data: imageData!) {
                    self?.thumbnailImageView?.image = image
                }
            }
        }
        self.videos = videos
        self.vc = vc
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchCell))
        addGestureRecognizer(tapGestureRecognizer!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let tgr = tapGestureRecognizer {
            removeGestureRecognizer(tgr)
        }
    }
    
    @objc
    func touchCell() {
        let storyboard = UIStoryboard(name: "Playlist", bundle: nil)
        if let pvc = storyboard.instantiateInitialViewController() as? PlaylistViewController {
            pvc.videos = videos
            vc.show(pvc, sender: self)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        frame.size.height = PlaylistsCollectionViewCell.frameHeight
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width / 4.0
        thumbnailImageView.layer.masksToBounds = true
    }

    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
