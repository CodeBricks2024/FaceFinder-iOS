//
//  UILabel+Style.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/16/24.
//

import UIKit

extension UILabel {
    
    static var headerBoldLabel: UILabel {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Appearance.Font.mediumSize)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }
    
    static var emojiLabel: UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: Appearance.Font.emojiLargeSize)
        return label
    }
}
