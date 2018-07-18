//
//  TagButton.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 18..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class TagButton: UIButton {
    
    private var fontSize = CGFloat(12.0)
    private(set) var tagName: String!
    weak var vc: UIViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = CGFloat(fontSize)
        layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.3843137255, blue: 0.5529411765, alpha: 1)
        layer.borderWidth = CGFloat(1.0)
        contentEdgeInsets = UIEdgeInsetsMake(fontSize / 2, fontSize / 2, fontSize / 2, fontSize / 2)
        addTarget(nil, action: #selector(touchButton), for: .touchUpInside)
    }
    
    func setFontSize(as fontSize: CGFloat) {
        self.fontSize = fontSize
    }
    
    func setTagName(as tag: String) {
        tagName = tag
        let font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let tagString = NSAttributedString(string: "#" + tag, attributes: [.paragraphStyle:paragraphStyle, .font: font, .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        let mutableTagString = NSMutableAttributedString(attributedString: tagString)
        
        mutableTagString.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.9098039216, green: 0.3843137255, blue: 0.5529411765, alpha: 1), range: NSMakeRange(0, 1))
        
        setAttributedTitle(mutableTagString as NSAttributedString, for: .normal)
    }
    
    @objc
    func touchButton() {
        let storyboard = UIStoryboard(name: "TagPlaylists", bundle: nil)
        if let pvc = storyboard.instantiateInitialViewController() as? TagPlaylistsViewController {
            pvc.tag = tagName
            vc.show(pvc, sender: self)
        }
    }
}
