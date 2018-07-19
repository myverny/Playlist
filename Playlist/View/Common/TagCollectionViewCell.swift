//
//  SearchTagCollectionViewCell.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 16..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagButton: TagButton!
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setUp(tag: Tag, vc: UIViewController) {
        tagButton.setTagName(as: tag)
        tagButton.vc = vc
    }
    
}
