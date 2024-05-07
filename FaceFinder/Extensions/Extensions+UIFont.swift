//
//  Extensions+UIFont.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import UIKit

extension UIFont {
    
    class func regularFont(with size: CGFloat) -> UIFont {
        return UIFont(name: "Spoqa Han Sans Neo Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    class func boldFont(with size: CGFloat) -> UIFont {
        return UIFont(name: "Spoqa Han Sans Neo Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func mediumFont(with size: CGFloat) -> UIFont {
        return UIFont(name: "Spoqa Han Sans Neo Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    //remove later
    class func lightFont(with size: CGFloat) -> UIFont {
        return UIFont(name: "Spoqa Han Sans Neo", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
