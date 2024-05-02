//
//  SceneTransitionType.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import UIKit

enum SceneTransitionType {
    case root(UIViewController)
    case push(UIViewController)
    case present(UIViewController)
    case alert(UIViewController)
    case tabBar(UITabBarController)
}
