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
    private var ref = Database.database().reference()
    
    func getDataRef() -> DatabaseReference {
        return ref.child("data")
    }
}

