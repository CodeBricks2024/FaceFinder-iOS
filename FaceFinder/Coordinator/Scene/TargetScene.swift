//
//  TargetScene.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import UIKit

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
}


extension Scene: TargetScene {
    var transition: SceneTransitionType {
        var vc = UIViewController()
        return .root(vc)
    }
}
