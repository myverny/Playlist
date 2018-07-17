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

class HomeViewModel: NSObject {
    var items = [HomeViewModelItem]()
    
    override init() {
        super.init()
        
        let todayItem = HomeViewModelTodayItem(title: "Worldcup 2018", desc: "France vs Croatia final", imgUrl: URL(fileURLWithPath: ""))
        items.append(todayItem)
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
