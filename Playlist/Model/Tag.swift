//
//  Tag.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 17..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Tag {
    let id: String
    let name: String
    let playlists: [String]
    
    init?(_ snapshot: DataSnapshot) {
        id = snapshot.key
        
        let nameSnapshot = snapshot.childSnapshot(forPath: "name")
        if let name = nameSnapshot.value as? String {
            self.name = name
            
            var playlists = [String]()
            let playlistsSnapshot = snapshot.childSnapshot(forPath: "playlists").children
            while let child = playlistsSnapshot.nextObject() as? DataSnapshot {
                playlists.append(child.key)
            }
            self.playlists = playlists
            return
        }
        return nil
    }
}
