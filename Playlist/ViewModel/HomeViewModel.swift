//
//  HomeViewModel.swift
//  Playlist
//
//  Created by dev on 2018. 7. 17..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

enum HomeViewModelItemType: String {
    case today = "today"
    case rank = "rank"
    case tag = "tag"
}

typealias CompletionHandler = (() -> Void)

class HomeViewModel: NSObject, FirebaseConnDelegate {

    var items = [HomeViewModelItem]()
    var tags: [String : Tag]? {
        didSet {
            if playlists != nil {
                prepareData()
            }
        }
    }
    var playlists: [String : Playlist]? {
        didSet {
            if tags != nil {
                prepareData()
            }
        }
    }
    var rankViewModel = [Int: HomeViewModelRankViewModel]()
    var todayViewModel: HomeViewModelTodayViewModel?
    
    weak var homevc: UIViewController!
    
    private var firebaseConn = FirebaseConn()
    private var completion: CompletionHandler!
    
    private func prepareData() {
        firebaseConn.getData(from: FirebaseConn.homePath) { snapshots in
            guard snapshots.count > 0 else { return }
            for snapshot in snapshots {
                if let value = snapshot.childSnapshot(forPath: "type").value as? String,
                    let type = HomeViewModelItemType(rawValue: value) {
                    switch type {
                    case .today:
                        if let todayItem = HomeViewModelTodayItem(snapshot: snapshot, playlists: self.playlists) {
                            self.todayViewModel = HomeViewModelTodayViewModel(todayItem, base: self, vc: self.homevc)
                            self.items.append(todayItem)
                        }
                    case .rank:
                        if let rankItem = HomeViewModelRankItem(snapshot: snapshot, playlists: self.playlists) {
                            self.rankViewModel[self.items.count] = HomeViewModelRankViewModel(rankItem, vc: self.homevc)
                            self.items.append(rankItem)
                        }
                    default:
                        break
                    }
                }
            }
            self.completion()
        }
    }
    
    func register(completion: @escaping CompletionHandler) {
        self.completion = completion
        firebaseConn.getPlaylists(self)
        firebaseConn.getTags(self)
    }
}

extension HomeViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .today:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TodayTableViewCell.identifier, for: indexPath) as? TodayTableViewCell,
                let todayItem = item as? HomeViewModelTodayItem,
                let playlist = todayItem.playlist {
                cell.tagCollectionView.dataSource = self.todayViewModel
                cell.setUp(title: playlist.title, desc: playlist.desc, imgUrl: playlist.imgUrl!, screenSize: tableView.bounds, viewCount: playlist.viewCount, bookmarkCount: playlist.bookmarkCount)
                cell.delegate = todayViewModel
                return cell
            }
        case .rank:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RankTableViewCell.identifier, for: indexPath) as? RankTableViewCell {
                cell.setCollectionViewDataSourceDelegate(rankViewModel[indexPath.section]!)
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}

extension HomeViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = items[section]
        switch item.type {
        case .today, .rank:
            if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: TodayTableHeader.identifier) as? TodayTableHeader {
                view.titleLabel.text = item.sectionTitle
                return view
            }
            
        default:
            return UIView()
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
