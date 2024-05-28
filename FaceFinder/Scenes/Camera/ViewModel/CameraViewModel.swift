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
    var moveAction: Action<UIImage, Void> { get }
    /// AVCapturePhotoOutput을 통하여 변환된 이미지를 전달
    var photoInputSubject: PublishSubject<UIImage?> { get }
    /// Capture된 Photo의 fileName과 file 경로를 CapturedPhotoData 객체화하여 전달
    var capturedPhotoData: PublishSubject<CapturedPhotoData?> { get }
    
}

protocol CameraViewModelOutput: BaseViewModelOutput {
    /// AVCapturePhotoOutput을 통해 변환된 이미지 전달
    var photoData: Observable<UIImage?> { get }
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
    
    lazy var moveAction: Action<UIImage, Void> = {
        return Action<UIImage, Void> { [unowned self] input in
            let vm = ResultViewModel(sceneCoordinator: self.sceneCoordinator, photo: input)
            return self.sceneCoordinator.transition(to: Scene.result(vm))
        }
    }()
    
    var photoInputSubject = PublishSubject<UIImage?>()
    var capturedPhotoData = PublishSubject<CapturedPhotoData?>()
 
    // MARK: - Output -
 
    var photoData = Observable<UIImage?>.just(nil)
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let service: MainServiceRepository
 
    init(sceneCoordinator: SceneCoordinatorType = SceneCoordinator.shared, service: MainServiceRepository = MainService()) {
        self.sceneCoordinator = sceneCoordinator
        self.service = service
        
        photoData = photoInputSubject.asObservable()
    }
}
