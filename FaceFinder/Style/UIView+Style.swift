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
    
    static var overlayView: UIView {
        let overlayView = UIView(frame: UIScreen.main.bounds)
        overlayView.backgroundColor = .clear
        let path = CGMutablePath()
        let size: CGFloat = 220.0
        
        path.addRoundedRect(in: CGRect(x: overlayView.center.x - (size/2), y: overlayView.center.y - size, width: size, height: size), cornerWidth: 30, cornerHeight: 30)
        path.closeSubpath()
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.contentsGravity = .resizeAspectFill
        shape.lineWidth = 5.0
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.clear.cgColor

        overlayView.layer.addSublayer(shape)
        

        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))

        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd

        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        
        return overlayView
    }
}

extension UIStackView {
    
    static var cameraFooterView: CameraFooterView {
        let view = CameraFooterView()
        return view
    }
    
}
