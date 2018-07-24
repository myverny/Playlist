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
    var todayViewModel = [Int: HomeViewModelTodayViewModel]()
    var tagViewModel = [Int: HomeViewModelTagViewModel]()

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
                            self.todayViewModel[self.items.count] = HomeViewModelTodayViewModel(todayItem, base: self, vc: self.homevc)
                            self.items.append(todayItem)
                        }
                    case .rank:
                        if let rankItem = HomeViewModelRankItem(snapshot: snapshot, playlists: self.playlists) {
                            self.rankViewModel[self.items.count] = HomeViewModelRankViewModel(rankItem, vc: self.homevc)
                            self.items.append(rankItem)
                        }
                    case .tag:
                        if let tagItem = HomeViewModelTagItem(snapshot: snapshot, tags: self.tags) {
                            self.tagViewModel[self.items.count] = HomeViewModelTagViewModel(tagItem, base: self, vc: self.homevc)
                            self.items.append(tagItem)
                        }
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
                cell.tagCollectionView.dataSource = self.todayViewModel[indexPath.section]
                cell.setUp(title: playlist.title, desc: playlist.desc, imgUrl: playlist.imgUrl!, screenSize: tableView.bounds, viewCount: playlist.viewCount, bookmarkCount: playlist.bookmarkCount)
                cell.delegate = self.todayViewModel[indexPath.section]
                return cell
            }
        case .rank:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RankTableViewCell.identifier, for: indexPath) as? RankTableViewCell {
                cell.setCollectionViewDataSourceDelegate(rankViewModel[indexPath.section]!)
                return cell
            }
        case .tag:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TagTableViewCell.identifier, for: indexPath) as? TagTableViewCell,
                let tagItem = item as? HomeViewModelTagItem {
                let tag = tagItem.tags[indexPath.item]
                cell.setCollectionViewDataSourceDelegate(tagViewModel[indexPath.section]!, forRow: indexPath.item)
                cell.setUp(title: tag.name)
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension HomeViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = items[section]
        switch item.type {
        case .today, .rank, .tag:
            if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: TodayTableHeader.identifier) as? TodayTableHeader {
                view.titleLabel.text = item.sectionTitle
                return view
            }
            /*
        default:
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView*/
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = items[section]
        switch item.type {
        case .today, .rank, .tag:
            return 50
        //default:
//            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let footerChildView = UIView(frame: CGRect(x: 60, y: 0, width: tableView.frame.width - 60, height: 1))
        footerChildView.backgroundColor = UIColor.clear
        footerView.addSubview(footerChildView)
        return footerView
    }
}
