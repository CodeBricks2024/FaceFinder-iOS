//
//  UIButton+Style.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/8/24.
//

import Foundation
import UIKit

extension UIButton {
    
    static var scanButton: UIButton {
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
