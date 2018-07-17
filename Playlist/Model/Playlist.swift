//
//  PlaylistViewModel.swift
//  Playlist
//
//  Created by dev on 2018. 7. 17..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation

struct Playlist {
    let id: Int
    let title: String
    let desc: String
    let videoIds: [Int]
    let viewCount: Int
    let bookmakrCount: Int
    let tags: [Int]
    
    init(dict: [String:Any]) {
        self.id = dict["id"] as! Int
        self.title = dict["title"] as? String ?? ""
        self.desc = dict["desc"] as? String ?? ""
        self.videoIds = []
        self.viewCount = dict["viewCount"] as? Int ?? 0
        self.bookmakrCount = dict["bookmarkCount"] as? Int ?? 0
        self.tags = []
    }
}

struct Tag {
    let id: Int
    let name: String
}
