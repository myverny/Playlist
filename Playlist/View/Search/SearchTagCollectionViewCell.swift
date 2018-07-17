//
//  SearchTagCollectionViewCell.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 16..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class SearchTagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagButton: UIButton! {
        didSet {
            tagButton.layer.cornerRadius = CGFloat(20.0)
            tagButton.layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.3843137255, blue: 0.5529411765, alpha: 1)
            tagButton.layer.borderWidth = CGFloat(1.0)
            tagButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
        }
    }
    
    func setTagName(as tag: String) {
        let font = UIFont.preferredFont(forTextStyle: .body).withSize(15)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let tagString = NSAttributedString(string: "#" + tag, attributes: [.paragraphStyle:paragraphStyle, .font: font, .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        let mutableTagString = NSMutableAttributedString(attributedString: tagString)
        
        mutableTagString.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.9098039216, green: 0.3843137255, blue: 0.5529411765, alpha: 1), range: NSMakeRange(0, 1))
            
        tagButton.setAttributedTitle(mutableTagString as NSAttributedString, for: .normal)
    }
}
