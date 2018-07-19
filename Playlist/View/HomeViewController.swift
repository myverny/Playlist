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

        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        
        // cells
        tableView?.register(TodayTableViewCell.nib, forCellReuseIdentifier: TodayTableViewCell.identifier)
        tableView?.register(RankTableViewCell.nib, forCellReuseIdentifier: RankTableViewCell.identifier)

        // headers
        tableView?.register(TodayTableHeader.nib, forHeaderFooterViewReuseIdentifier: TodayTableHeader.identifier)

        viewModel.register { [weak self] in
            self?.tableView?.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
