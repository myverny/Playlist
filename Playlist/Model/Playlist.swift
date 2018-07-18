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
    let videoIds: [String]
    let viewCount: Int
    let bookmakrCount: Int
    let tagIds: [Int]
    
    init(dict: [String:Any]) {
        self.id = dict["id"] as! Int
        self.title = dict["title"] as? String ?? ""
        self.desc = dict["desc"] as? String ?? ""
        self.viewCount = dict["viewCount"] as? Int ?? 0
        self.bookmakrCount = dict["bookmarkCount"] as? Int ?? 0

        var videoIds = [String]()
        for (key, _) in dict["videos"] as! [String:Any] {
            videoIds.append(key)
        }
        self.videoIds = videoIds
        
        var tagIds = [Int]()
        if let tags = dict["tags"] as? [String:Any] {
            for (key, _) in tags {
                tagIds.append(Int(key)!)
            }
        } else if let tags = dict["tags"] as? [Any] {
            tagIds = Array(0...tags.count)
        }
        self.tagIds = tagIds

    }
}

struct Tag {
    let id: Int
    let name: String
}
