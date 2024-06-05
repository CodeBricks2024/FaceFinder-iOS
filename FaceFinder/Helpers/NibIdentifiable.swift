//
//  NibIdentifiable.swift
//  FaceFinder
//
//  Created by Songkyung Min on 6/5/24.
//

import UIKit

protocol NibIdentifiable: class {
    static var nib: UINib { get }
}

extension NibIdentifiable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension NibIdentifiable where Self: UICollectionView {
    static func initFromNib() -> Self {
        guard let collectionView = nib.instantiate(withOwner: nil, options: nil).first as? Self
            else { fatalError("Couldn't find nib file for \(self)") }
        return collectionView
    }
}

extension NibIdentifiable where Self: UIViewController {
    static func initFromNib() -> Self {
       return Self(nibName: nibIdentifier, bundle: nil)
    }
}

extension UIViewController: NibIdentifiable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}
