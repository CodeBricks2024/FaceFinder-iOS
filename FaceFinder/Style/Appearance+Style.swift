//
//  Appearance+Style.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import UIKit

enum Appearance {}

extension Appearance {
 
    enum Layer {
        static let defaultRadius: CGFloat = 10.0
    }
    
    enum Margin {
        static let horizontalMargin: CGFloat = 24.0
        static let verticalMargin: CGFloat = 16.0
        static let imgViewMargin: CGFloat = 47.0
    }
    
    enum Size {
        static let defaultHeight: CGFloat = 56.0
        static let headerHeight: CGFloat = 50.0
        static let iconSize: CGFloat = 30.0
        static let imageSize: CGFloat = 255.0
    }
    
    enum Icon {
        static let album = UIImage(named: "album")
        static let scanzone = UIImage(named: "scanzone")
        static let back = UIImage(named: "back")
        static let logo = UIImage(named: "Logo")
        static let switchCamera = UIImage(named: "switch")
    }
    
    enum Image {
        static let overlay = UIImage(named: "overlay")
        static let shutter = UIImage(named: "shutter")
        static let sampleImg = UIImage(named: "sample")
        static let placeholder = UIImage(named: "sample")
    }
    
    enum Font {
        static let mediumSize: CGFloat = 24.0
        static let regularSize: CGFloat = 16.0
    }
    
}
