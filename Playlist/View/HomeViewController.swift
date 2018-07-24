//
//  HomeViewController.swift
//  Playlist
//
//  Created by dev on 2018. 7. 16..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    private let viewModel = HomeViewModel()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.homevc = self
        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
        
        // cells
        tableView?.register(TodayTableViewCell.nib, forCellReuseIdentifier: TodayTableViewCell.identifier)
        tableView?.register(RankTableViewCell.nib, forCellReuseIdentifier: RankTableViewCell.identifier)
        tableView?.register(TagTableViewCell.nib, forCellReuseIdentifier: TagTableViewCell.identifier)

        // headers
        tableView?.register(TodayTableHeader.nib, forHeaderFooterViewReuseIdentifier: TodayTableHeader.identifier)

        viewModel.register { [weak self] in
            self?.tableView?.reloadData()
        }
    }

}
