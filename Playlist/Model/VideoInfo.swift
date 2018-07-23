//
//  VideoInfo.swift
//  Playlist
//
//  Created by dev on 2018. 7. 20..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation

struct VideoInfo: Decodable {
    let id: String
    let snippet: Snippet
    let statistics: Statistics

    struct Snippet: Decodable {
        let title: String
        
        enum CodingKeys : String, CodingKey {
            case title
        }
    }
    
    struct Statistics: Decodable {
        let viewCount: String
        enum CodingKeys : String, CodingKey {
            case viewCount
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case id
        case snippet
        case statistics
    }
}

struct VideoInfoContainer: Decodable {
    let items: [VideoInfo]
    enum CodingKeys : String, CodingKey {
        case items
    }
}
