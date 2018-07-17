//
//  HomeViewModel.swift
//  Playlist
//
//  Created by dev on 2018. 7. 17..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import UIKit

enum HomeViewModelItemType {
    case today
    case rank
    case tag
}

protocol HomeViewModelItem {
    var type: HomeViewModelItemType { get }
    var rowCount: Int { get }
}

typealias CompletionHandler = (() -> Void)

class HomeViewModel: NSObject {
    var items = [HomeViewModelItem]()
    
    private var firebaseConn = FirebaseConn()
    private var completion: CompletionHandler!
    private var playlists = [Playlist]() {
        didSet {
            firebaseConn.getData(from: FirebaseConn.todayPath) { [weak self] data in
                if let todayList = data as? [Any],
                    let today = todayList[0] as? Int,
                    let todayPlaylist = self?.playlists[today] as? Playlist {
                    let todayItem = HomeViewModelTodayItem(title: todayPlaylist.title, desc: todayPlaylist.desc, imgUrl: URL(fileURLWithPath: ""))
                    self?.items.append(todayItem)
                }
            }
        }
    }
    
    func register(completion: @escaping CompletionHandler) {
        self.completion = completion
        firebaseConn.getData(from: FirebaseConn.playlistsPath) { [weak self] data in
            var newPlaylists = [Playlist]()
            if let playlists = data as? [Any] {
                for playlist in playlists {
                    newPlaylists.append(Playlist(dict: playlist as! [String:Any]))
                }
            }
            self?.playlists = newPlaylists
        }
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
                
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}


class HomeViewModelTodayItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .today
    }
    
    var sectionTitle: String {
        return "Today"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var title: String
    var desc: String
    var imgUrl: URL
    
    init(title: String, desc: String, imgUrl: URL) {
        self.title = title
        self.desc = desc
        self.imgUrl = imgUrl
    }
}
