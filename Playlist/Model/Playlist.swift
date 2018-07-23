//
//  PlaylistViewModel.swift
//  Playlist
//
//  Created by dev on 2018. 7. 17..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Playlist {
    let id: String
    let title: String
    let desc: String
    let videos: [String]
    let viewCount: Int
    let bookmarkCount: Int
    let tags: [String]
    var imgUrl: URL? {
        get {
            return URL(string: String(format: "https://img.youtube.com/vi/%@/mqdefault.jpg", videos[0]))
        }
    }
    
    init?(_ snapshot: DataSnapshot) {
        self.id = snapshot.key
        
        let titleSnapshot = snapshot.childSnapshot(forPath: "title")
        if let title = titleSnapshot.value as? String {
            self.title = title
        } else {
            return nil
        }
        let descSnapshot = snapshot.childSnapshot(forPath: "desc")
        if let desc = descSnapshot.value as? String {
            self.desc = desc
        } else {
            return nil
        }
        let viewCountSnapshot = snapshot.childSnapshot(forPath: "viewCount")
        if let viewCount = viewCountSnapshot.value as? Int {
            self.viewCount = viewCount
        } else {
            self.viewCount = 0
        }
        let bookmarkCountSnapshot = snapshot.childSnapshot(forPath: "bookmarkCount")
        if let bookmarkCount = bookmarkCountSnapshot.value as? Int {
            self.bookmarkCount = bookmarkCount
        } else {
            self.bookmarkCount = 0
        }
        
        var tags = [String]()
        let tagsSnapshot = snapshot.childSnapshot(forPath: "tags").children
        while let child = tagsSnapshot.nextObject() as? DataSnapshot {
            tags.append(child.key)
        }
        self.tags = tags
        
        var videos = [String]()
        let videosSnapshot = snapshot.childSnapshot(forPath: "videos").children
        while let child = videosSnapshot.nextObject() as? DataSnapshot {
            if let index = Int(child.key),
                let key = child.value as? String {
                videos.insert(key, at: index)
            }
        }
        self.videos = videos
    }
}

