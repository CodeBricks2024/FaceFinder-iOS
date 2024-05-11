//
//  Extension+UIApplication.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/11/24.
//

import UIKit

extension UIApplication {
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11, *) {
            return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets ?? .zero
        }
        return .zero
    }
}
