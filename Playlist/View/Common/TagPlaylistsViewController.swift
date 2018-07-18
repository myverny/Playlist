//
//  TagPlaylistsViewController.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 18..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class TagPlaylistsViewController: UIViewController {
    var tag: Tag!
    private var viewModel: TagPlaylistsViewModel!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            viewModel = TagPlaylistsViewModel(tag, vc: self)
            tableView.dataSource = viewModel
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.register(TodayTableViewCell.nib, forCellReuseIdentifier: TodayTableViewCell.identifier)
        }
    }
    
}
