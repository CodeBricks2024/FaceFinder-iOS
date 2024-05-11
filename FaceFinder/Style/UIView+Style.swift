//
//  UIView+Style.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import UIKit

extension UIView {
    
    static var plainView: UIView {
        let view = UIView()
        view.backgroundColor = .clear

        return view
    }
    
    static var cameraView: CameraView {
        let view = CameraView()
        return view
    }
    
}

extension UIStackView {
    
    static var cameraFooterView: CameraFooterView {
        let view = CameraFooterView()
        return view
    }
    
}
