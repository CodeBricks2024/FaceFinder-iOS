//
//  UIButton+Style.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/8/24.
//

import Foundation
import UIKit

extension UIButton {
    
    static var bottomButton: UIButton {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.primaryColor
        button.layer.cornerRadius = Appearance.Layer.defaultRadius
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        return button
    }
    
    static var backButton: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.add, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.widthAnchor.constraint(equalToConstant: .defaultHeight).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    
}
