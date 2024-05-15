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
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        button.setImage(.back, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = Appearance.Layer.defaultRadius
        return button
    }
    
    static var albumButton: UIButton {
        let button = UIButton()
        button.setImage(.album, for: .normal)
        return button
    }
    
    static var cameraSwitchButton: UIButton {
        let button = UIButton()
        button.setImage(.switch, for: .normal)
        return button
    }
}
