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
    static var cache = [String: Any]()
    static var tagsPath = FirebaseConn.ref.child("data/tags")
    static var playlistsPath = FirebaseConn.ref.child("data/playlists")
    
    func getData(from childRef: DatabaseReference, completion: @escaping (Any) -> Void) {
        let key = childRef.key
        if let cacheData = FirebaseConn.cache[key] {
            completion(cacheData)
            return
        }
        
        childRef.observeSingleEvent(of: .value) { snapshot in
            if let snapshotData = snapshot.value {
                FirebaseConn.cache[key] = snapshotData
                completion(snapshotData)
            }
        }
    }
    
}

