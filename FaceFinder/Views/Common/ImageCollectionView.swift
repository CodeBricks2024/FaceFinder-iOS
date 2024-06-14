//
//  ImageCollectionView.swift
//  FaceFinder
//
//  Created by Songkyung Min on 6/5/24.
//

import UIKit

final class ImageCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    convenience init(direction: UICollectionView.ScrollDirection) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        self.init(frame: .zero, collectionViewLayout: layout)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .clear
        self.allowsMultipleSelection = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
