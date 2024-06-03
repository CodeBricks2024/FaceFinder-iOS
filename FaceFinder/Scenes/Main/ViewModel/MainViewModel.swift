//
//  MainViewModel.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/8/24.
//

import Foundation
import RxSwift
import RxCocoa
import Action

protocol MainViewModelInput: BaseViewModelInput {
    var scanAction: CocoaAction { get }
}

protocol MainViewModelOutput: BaseViewModelOutput {
}

protocol MainViewModelType {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}

class MainViewModel: MainViewModelInput, MainViewModelOutput, MainViewModelType {
    
    
    var input: MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var scanAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            let vm = CameraViewModel()
            return self.sceneCoordinator.transition(to: Scene.camera(vm))
        }
    }()
    
 
    // MARK: - Output -
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let service: MainServiceRepository
    
    init(sceneCoordinator: SceneCoordinatorType = SceneCoordinator.shared, service: MainServiceRepository = MainService()) {
        self.sceneCoordinator = sceneCoordinator
        self.service = service
    }
}
