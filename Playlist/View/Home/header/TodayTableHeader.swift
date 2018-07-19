//
//  TodayTableHeader.swift
//  Playlist
//
//  Created by dev on 2018. 7. 18..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class TodayTableHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
