//
//  FoundationExtension.swift
//  Playlist
//
//  Created by dev on 2018. 7. 19..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import Foundation

extension Int {
    func toAbbr() -> String {
        let units = [(1000000, "M"), (1000, "K")]
        
        for (unit, abbr) in units {
            if self >= unit {
                let n = self / unit
                let r = (self - (n * unit)) * 10 / unit
                return "\(n).\(r)\(abbr)"
            }
        }
        return "\(self)"
    }
}
