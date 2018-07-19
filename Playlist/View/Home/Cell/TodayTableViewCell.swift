//
//  TodayTableViewCell.swift
//  Playlist
//
//  Created by dev on 2018. 7. 17..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class TodayTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(title: String, desc: String, imgUrl: URL, screenSize: CGRect) {
        titleLabel?.text = title
        descLabel?.text = desc
        DispatchQueue.global().async() {
            let imageData = try? Data(contentsOf: imgUrl)
            DispatchQueue.main.async() { [weak self] in
                if imageData != nil, let image = UIImage(data: imageData!) {
                    self?.thumbnailImageView?.image = image
                    self?.thumbnailImageView?.frame.size.width = screenSize.width
                    self?.thumbnailImageView?.frame.size.height = screenSize.width / image.size.width * image.size.height
                }
            }
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
