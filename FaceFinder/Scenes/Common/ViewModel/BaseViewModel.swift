//
//  BaseViewModel.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import Foundation
import Action

protocol BaseViewModelInput {
}

protocol BaseViewModelOutput {
}

protocol BaseViewModelType {
    var baseInput: BaseViewModelInput { get }
    var baseOutput: BaseViewModelOutput { get }
}

class BaseViewModel: BaseViewModelInput, BaseViewModelOutput, BaseViewModelType {
    
    var baseInput: BaseViewModelInput { return self }
    var baseOutput: BaseViewModelOutput { return self }
    
    // MARK: - Input -
    
    // MARK: - Output -
    
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
}
