//
//  CameraViewModel.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/8/24.
//

import Foundation
import RxSwift
import RxCocoa


protocol CameraViewModelInput: BaseViewModelInput {
    
}

protocol CameraViewModelOutput: BaseViewModelOutput {
}

protocol CameraViewModelType {
    var input: CameraViewModelInput { get }
    var output: CameraViewModelOutput { get }
}

class CameraViewModel: CameraViewModelInput, CameraViewModelOutput, CameraViewModelType {
    
    var input: CameraViewModelInput { return self }
    var output: CameraViewModelOutput { return self }
    
    // MARK: - Input -
 
    // MARK: - Output -
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
 
    init(sceneCoordinator: SceneCoordinatorType = SceneCoordinator.shared) {
        self.sceneCoordinator = sceneCoordinator
    }
}
