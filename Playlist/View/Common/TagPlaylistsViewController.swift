//
//  TagPlaylistsViewController.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 18..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class TagPlaylistsViewController: UIViewController {
    
    var tag: String! {
        didSet {
            self.title = tag
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
