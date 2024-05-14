//
//  ResultViewModel.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/14/24.
//

import Foundation
import Action

protocol ResultViewModelInput {
    var backAction: CocoaAction { get }
}

protocol ResultViewModelOutput {
}

protocol ResultViewModelType {
    var input: ResultViewModelInput { get }
    var output: ResultViewModelOutput { get }
}

class ResultViewModel: ResultViewModelInput, ResultViewModelOutput, ResultViewModelType {
    
    var input: ResultViewModelInput { return self }
    var output: ResultViewModelOutput { return self }
    
    
    // MARK: - Input -
    
    lazy var backAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.pop(animated: true).asObservable().map { _ in }
        }
    }()
    
    // MARK: - Output -
    
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
}
