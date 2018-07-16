//
//  LoginTableViewCell.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 16..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class LoginTableViewCell: UITableViewCell {
    var delegate: LoginTableViewCellDelegate?
    
    @IBOutlet weak var loginModeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func pressLoginButton(_ sender: UIButton) {
        delegate?.login()
    }
}
