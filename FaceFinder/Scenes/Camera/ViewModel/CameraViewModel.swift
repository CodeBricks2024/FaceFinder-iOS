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
import Toaster

protocol CameraViewModelInput: BaseViewModelInput {
    var backAction: CocoaAction { get }
    var dismissAction: CocoaAction { get }
    var moveAction: Action<ComparedData, Void> { get }
    /// AVCapturePhotoOutput을 통하여 변환된 이미지를 전달
    var photoInputSubject: PublishSubject<UIImage?> { get }
    /// Capture된 Photo의 fileName과 file 경로를 CapturedPhotoData 객체화하여 전달
    var capturedPhotoData: PublishSubject<CapturedPhotoData?> { get }
    
}

protocol CameraViewModelOutput: BaseViewModelOutput {
    /// AVCapturePhotoOutput을 통해 변환된 이미지 전달
    var photoData: Observable<ComparedData?> { get }
    /// API 리퀘스트에 대한 결과 받았을 때, 인디케이터 뷰 스탑해주기 위한 플래그
    var requestDone: PublishSubject<Bool> { get }
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
    
    lazy var moveAction: Action<ComparedData, Void> = {
        return Action<ComparedData, Void> { [unowned self] input in
            guard let originalImg = input.original_image else { return Observable.just(()) }
            
            let imageData = originalImg.resizeImage().jpegData(compressionQuality: 0.8)
            var request = CompareRequest()
            request.image_file = imageData
            
            return self.service.sendImage(with: request)
                .flatMap { result -> Observable<Void> in
                    self.requestDone.onNext(true)
                    switch result {
                    case let .success(response):
                        print("res: \(response)")
                        let vm = ResultViewModel(sceneCoordinator: self.sceneCoordinator, data: input, response: response)
                        return self.sceneCoordinator.transition(to: Scene.result(vm))
                    case let .failure(error):
                        let errorMessage = error.localizedDescription
                        Toast(text: errorMessage).show()
                        return .empty()
                    }
                }
        }
    }()
    
    var photoInputSubject = PublishSubject<UIImage?>()
    var capturedPhotoData = PublishSubject<CapturedPhotoData?>()
 
    // MARK: - Output -
 
    var photoData = Observable<ComparedData?>.just(nil)
    var requestDone = PublishSubject<Bool>()
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let service: MainServiceRepository
    private var photoDataArr: [UIImage] = []
    
    init(sceneCoordinator: SceneCoordinatorType = SceneCoordinator.shared, service: MainServiceRepository = MainService()) {
        self.sceneCoordinator = sceneCoordinator
        self.service = service
        
        requestDone.onNext(false)
        
        photoData = photoInputSubject.asObservable().unwrap()
            .flatMap { photo -> Observable<ComparedData?> in
                var data = ComparedData()
                data.original_image = photo
                return .just(data)
            }
    }
}
