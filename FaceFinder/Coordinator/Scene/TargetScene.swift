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
    case splash(SplashViewModel)
    case main(MainViewModel)
    case camera(CameraViewModel)
}


extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
            case let .splash(viewModel):
                var vc = SplashViewController()
                vc.bind(to: viewModel)
                return .root(vc)
            
            case let .main(viewModel):
                var vc = MainViewController()
                vc.bind(to: viewModel)
//                return .push(vc)
                return .root(vc)
            
            case let .camera(viewModel):
                var vc = CameraViewController()
                vc.bind(to: viewModel)
                return .push(vc)
        }
    }
}
