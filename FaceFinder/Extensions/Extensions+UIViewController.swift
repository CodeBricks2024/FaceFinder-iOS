//
//  Extensions+UIViewController.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/8/24.
//

import UIKit

protocol LayoutGuideProvider {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}

extension UILayoutGuide: LayoutGuideProvider {}

class CustomLayoutGuide: LayoutGuideProvider {
    let topAnchor: NSLayoutYAxisAnchor
    let bottomAnchor: NSLayoutYAxisAnchor
    init(topAnchor: NSLayoutYAxisAnchor, bottomAnchor: NSLayoutYAxisAnchor) {
        self.topAnchor = topAnchor
        self.bottomAnchor = bottomAnchor
    }
}


//Disable swiping back to previous view controller
extension UIViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    var layoutInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        } else {
            return UIEdgeInsets(top: topLayoutGuide.length,
                                left: 0.0,
                                bottom: bottomLayoutGuide.length,
                                right: 0.0)
        }
    }
    
    var layoutGuide: LayoutGuideProvider {
        if #available(iOS 11.0, *) {
            return view!.safeAreaLayoutGuide
        } else {
            return CustomLayoutGuide(topAnchor: topLayoutGuide.bottomAnchor,
                                     bottomAnchor: bottomLayoutGuide.topAnchor)
        }
    }
}

extension UIViewController {
    
    func showAlert(type: ShowAlertType, title: String, message: String, okAction: UIAlertAction, cancelAction: UIAlertAction? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        switch type {
        case .one:
            let okAction = okAction
            alertController.addAction(okAction)
            break

        case .two:
            let okAction = okAction
            let cancelAction = cancelAction ?? UIAlertAction(title: .cancel, style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
        }
        present(alertController, animated: true, completion: nil)
    }
}
