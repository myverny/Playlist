//
//  HomeViewModelItem.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 19..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol HomeViewModelItem {
    var type: HomeViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get set }
}

class HomeViewModelTodayItem: HomeViewModelItem {
    var sectionTitle: String
    
    var type: HomeViewModelItemType {
        return .today
    }
    
    var rowCount: Int {
        return 1
    }
    
    var playlist: Playlist?
    
    init?(snapshot: DataSnapshot, playlists: [String : Playlist]?) {
        guard let value = snapshot.childSnapshot(forPath: "playlist").value as? String,
            let todayPlaylist = playlists?[value] else {
            return nil
        }
        self.playlist = todayPlaylist
        self.sectionTitle = snapshot.childSnapshot(forPath: "title").value as? String ?? ""
    }
}

class HomeViewModelRankItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .rank
    }
   
    var sectionTitle: String

    var rowCount: Int {
        return 1
    }
    
    var ranks = [Playlist]()
    
    init?(snapshot: DataSnapshot, playlists: [String : Playlist]?) {
        guard let rankSnashots = snapshot.childSnapshot(forPath: "rank").children.allObjects as? [DataSnapshot] else {
                return nil
            }
        
        var ranks = [Playlist]()
        for rank in rankSnashots {
            if let index = Int(rank.key),
                let id = rank.value as? String,
                let playlist = playlists?[id] {
                ranks.insert(playlist, at: index - 1)
            }
        }
        if ranks.isEmpty {
            return nil
        }
            
        self.ranks = ranks
        self.sectionTitle = snapshot.childSnapshot(forPath: "title").value as? String ?? ""
    }
}

class HomeViewModelTagItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .tag
    }
    
    var sectionTitle: String
    
    var rowCount: Int
    
    var tags = [Tag]()
    
    init?(snapshot: DataSnapshot, tags: [String : Tag]?) {
        guard let rankSnashots = snapshot.childSnapshot(forPath: "tags").children.allObjects as? [DataSnapshot] else {
            return nil
        }
        
        var topTags = [Tag]()
        for tag in rankSnashots {
            if let topTag = tags?[tag.key] {
                topTags.append(topTag)
            }
        }
        if topTags.isEmpty {
            return nil
        }
        
        self.rowCount = topTags.count
        self.tags = topTags
        self.sectionTitle = snapshot.childSnapshot(forPath: "title").value as? String ?? ""
    }
}
