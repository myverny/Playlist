//
//  FirebaseConn.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 17..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseConn {
    static private var ref = Database.database().reference()
    static var cache = [String: [DataSnapshot]]()
    static var tagsPath = FirebaseConn.ref.child("data/tags")
    static var playlistsPath = FirebaseConn.ref.child("data/playlists")
    static var todayPath = FirebaseConn.ref.child("data/today")
    
    weak var delegate: FirebaseConnDelegate?
    
    func getData(from childRef: DatabaseReference, completion: @escaping ([DataSnapshot]) -> Void) {
        let key = childRef.key
        if let cacheData = FirebaseConn.cache[key] {
            completion(cacheData)
            return
        }
        
        childRef.observeSingleEvent(of: .value) { snapshot in
            if let snapshotData = snapshot.children.allObjects as? [DataSnapshot] {
                FirebaseConn.cache[key] = snapshotData
                completion(snapshotData)
            }
        }
    }
    
    func getTags() {
        getData(from: FirebaseConn.tagsPath) {
            snapshots in
            var tags = [Tag]()
            for snapshot in snapshots {
                if let tag = Tag.init(snapshot) {
                    tags.append(tag)
                }
            }
            self.delegate?.tags = tags
        }
    }
    
    func getPlaylists() {
        
    }
}

