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
        label.font = .boldSystemFont(ofSize: Appearance.Font.regularSize)
        label.numberOfLines = 0
        return label
    }
}
