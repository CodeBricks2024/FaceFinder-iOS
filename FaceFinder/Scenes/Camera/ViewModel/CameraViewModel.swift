//
//  CameraViewModel.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/8/24.
//

import Foundation
import RxSwift
import RxCocoa
import Action


protocol CameraViewModelInput: BaseViewModelInput {
    var backAction: CocoaAction { get }
    var dismissAction: CocoaAction { get }
    /// AVCapturePhotoOutput을 통하여 변환된 이미지를 전달
    var photoInputSubject: PublishSubject<UIImage?> { get }
    /// Capture된 Photo의 fileName과 file 경로를 CapturedPhotoData 객체화하여 전달
    var capturedPhotoData: PublishSubject<CapturedPhotoData?> { get }
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
    
    lazy var backAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.pop(animated: true).asObservable().map { _ in }
        }
    }()
    
    lazy var dismissAction: CocoaAction = {
        CocoaAction { [unowned self] _ in
            return self.sceneCoordinator.dismiss(animated: true).asObservable().map { _ in }
        }
    }()
    
    
    var photoInputSubject = PublishSubject<UIImage?>()
    var capturedPhotoData = PublishSubject<CapturedPhotoData?>()
    
    
 
    // MARK: - Output -
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
 
    init(sceneCoordinator: SceneCoordinatorType = SceneCoordinator.shared) {
        
        self.sceneCoordinator = sceneCoordinator
    }
}
