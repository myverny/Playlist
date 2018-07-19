//
//  CenterViewFlowLayout.swift
//  UICollectionViewHorizontalPaging
//
//  Created by Maxim on 2/6/16.
//  Copyright © 2016 Maxim Bilan. All rights reserved.
//

import UIKit

class CenterViewFlowLayout: UICollectionViewFlowLayout {
    
    override var collectionViewContentSize : CGSize {
        // Only support single section for now.
        // Only support Horizontal scroll
        let count = self.collectionView?.dataSource?.collectionView(self.collectionView!, numberOfItemsInSection: 0)
        let canvasSize = self.collectionView!.frame.size
        var contentSize = canvasSize
        if self.scrollDirection == UICollectionViewScrollDirection.horizontal {
            let rowCount = Int((canvasSize.height - self.itemSize.height) / (self.itemSize.height + self.minimumInteritemSpacing) + 1)
            let columnCount = Int((canvasSize.width - self.itemSize.width) / (self.itemSize.width + self.minimumLineSpacing) + 1)
            let page = ceilf(Float(count!) / Float(rowCount * columnCount))
            contentSize.width = CGFloat(page) * canvasSize.width
        }
        return contentSize
    }
    
}
