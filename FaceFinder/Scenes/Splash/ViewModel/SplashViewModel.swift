//
//  SplashViewModel.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import RxSwift

protocol SplashViewModelInput {
    
}

protocol SplashViewModelOutput {
    
}

protocol SplashViewModelType {
    var input: SplashViewModelInput { get }
    var output: SplashViewModelOutput { get }
}

class SplashViewModel: SplashViewModelInput, SplashViewModelOutput, SplashViewModelType {
    
    var input: SplashViewModelInput { return self }
    var output: SplashViewModelOutput { return self }
    
    // MARK: - Input -
 
    // MARK: - Output -
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
 
    init(sceneCoordinator: SceneCoordinatorType = SceneCoordinator.shared) {
        self.sceneCoordinator = sceneCoordinator
    }
}
