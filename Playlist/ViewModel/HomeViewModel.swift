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

enum HomeViewModelItemType {
    case today
    case rank
    case tag
}

typealias CompletionHandler = (() -> Void)

class HomeViewModel: NSObject, FirebaseConnDelegate {

    var items = [HomeViewModelItem]()
    var tags: [String : Tag]?
    var playlists: [String : Playlist]? {
        didSet {
            prepareData()
        }
    }
    var rankViewModel = [Int: HomeViewModelRankViewModel]()
    
    private var firebaseConn = FirebaseConn()
    private var completion: CompletionHandler!
    
    private func prepareData() {
        firebaseConn.getData(from: FirebaseConn.todayPath) { snapshots in
            guard snapshots.count > 0 else { return }
            let todayData = snapshots[0]
            if let todayPlaylist = self.playlists?[todayData.key] {
                let todayItem = HomeViewModelTodayItem(
                    title: todayPlaylist.title,
                    desc: todayPlaylist.desc,
                    imgUrl: todayPlaylist.imgUrl
                )
                self.items.append(todayItem)
                self.completion()
            }
        }
        
        firebaseConn.getData(from: FirebaseConn.rankPath) { snapshots in
            guard snapshots.count > 0 else { return }
            var ranks = [Playlist]()
            for rank in snapshots {
                if let playlist = self.playlists?[rank.key] {
                    ranks.append(playlist)
                }
            }
            if ranks.count > 0 {
                let rankItem = HomeViewModelRankItem()
                rankItem.ranks = ranks
                self.rankViewModel[self.items.count] = HomeViewModelRankViewModel(rankItem)
                self.items.append(rankItem)
            }
            self.completion()
        }
    }
    
    func register(completion: @escaping CompletionHandler) {
        self.completion = completion
        firebaseConn.getPlaylists(self)
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
                let todayItem = item as? HomeViewModelTodayItem {
                cell.titleLabel?.text = todayItem.title
                cell.descLabel?.text = todayItem.desc
                if todayItem.imgUrl != nil {
                    DispatchQueue.global().async() {
                        let imageData = try? Data(contentsOf: todayItem.imgUrl!)
                        DispatchQueue.main.async() {
                            if imageData != nil, let image = UIImage(data: imageData!) {
                                cell.thumbnailImageView?.image = image
                                let screenSize = tableView.bounds
                                cell.thumbnailImageView?.frame.size.width = screenSize.width
                                cell.thumbnailImageView?.frame.size.height = screenSize.width / image.size.width * image.size.height
                            }
                        }
                    }
                }
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
        case .today:
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
