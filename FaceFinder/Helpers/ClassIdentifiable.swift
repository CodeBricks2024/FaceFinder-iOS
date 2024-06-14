//
//  ClassIdentifiable.swift
//  FaceFinder
//
//  Created by Songkyung Min on 6/5/24.
//

import UIKit

protocol ClassIdentifiable: class {
    static var reuseId: String { get }
}

extension ClassIdentifiable {
    static var reuseId: String {
        return String(describing: self)
    }
}
