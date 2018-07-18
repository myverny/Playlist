//
//  FirebaseConnDelegate.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 18..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation

protocol FirebaseConnDelegate: class {
    var tags: [Tag]? { get set }
    var playlists: [Playlist]? { get set }
}
