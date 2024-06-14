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
    
    static var navView: NavigationView {
        let view = NavigationView()
        return view
    }
    
    static var mainHeaderView: MainHeaderView {
        let view = MainHeaderView()
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
    
    static var horizontalStackView: UIStackView {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }
    
    static var cameraFooterView: CameraFooterView {
        let view = CameraFooterView()
        return view
    }
    
}

extension UIImageView {
    
    static var roundedImgView: UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = Appearance.Layer.defaultRadius
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.image = Appearance.Image.sampleImg
        return view
    }
    
    static var plainImgView: UIImageView {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }
}
