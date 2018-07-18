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

protocol HomeViewModelItem {
    var type: HomeViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

typealias CompletionHandler = (() -> Void)

class HomeViewModel: NSObject {
    var items = [HomeViewModelItem]()
    
    private var firebaseConn = FirebaseConn()
    private var completion: CompletionHandler!
    private var playlists = [String:Playlist]() {
        didSet {
            prepareData()
        }
    }
    
    private func prepareData() {
        firebaseConn.getData(from: FirebaseConn.todayPath) { [weak self] snapshots in
            guard snapshots.count > 0 else { return }
            let todayData = snapshots[0]
            if let todayPlaylist = self?.playlists[todayData.key] {
                let todayItem = HomeViewModelTodayItem(
                    title: todayPlaylist.title,
                    desc: todayPlaylist.desc,
                    imgUrl: URL(string: String(format: "https://img.youtube.com/vi/%@/0.jpg", todayPlaylist.videos[0]))
                )
                self?.items.append(todayItem)
                self?.completion()
            }
        }
    }
    
    func register(completion: @escaping CompletionHandler) {
        self.completion = completion
        firebaseConn.getData(from: FirebaseConn.playlistsPath) { [weak self] snapshots in
            var playlists = [String:Playlist]()
            for snapshot in snapshots {
                if let playlist = Playlist.init(snapshot) {
                    playlists[playlist.id] = playlist
                }
            }
            self?.playlists = playlists
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
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
        return "오늘의 동영상 리스트"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var title: String
    var desc: String
    var imgUrl: URL?
    
    init(title: String, desc: String, imgUrl: URL?) {
        self.title = title
        self.desc = desc
        self.imgUrl = imgUrl
    }
}
