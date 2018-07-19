//
//  HomeViewModelItem.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 19..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation

protocol HomeViewModelItem {
    var type: HomeViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

class HomeViewModelTodayItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .today
    }
    
    var sectionTitle: String {
        return "오늘의 동영상 리스트"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var title: String
    var desc: String
    var imgUrl: URL?
    
    init(title: String, desc: String, imgUrl: URL?) {
        self.title = title
        self.desc = desc
        self.imgUrl = imgUrl
    }
}

class HomeViewModelRankItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .rank
    }
    
    var sectionTitle: String {
        return "동영상 리스트 순위"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var ranks = [Playlist]()
}
