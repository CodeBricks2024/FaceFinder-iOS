//
//  ResultViewModel.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/14/24.
//

import Foundation
import Action
import RxSwift

protocol ResultViewModelInput {
    var backAction: CocoaAction { get }
}

protocol ResultViewModelOutput {
    var originalPhotoImage: Observable<UIImage> { get }
    /// 컬렉션 뷰에 표시할 thumbnail 이미지 데이터
    var thumbnailPhotoData: Observable<[UIImage]> { get }
    var closestMatchName: Observable<String> { get }
    var emotionName: Observable<String> { get }
    var emoji: Observable<String> { get }
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
    
    
    // MARK: - Output
  
    var thumbnailPhotoData = Observable<[UIImage]>.just([])
    var originalPhotoImage: Observable<UIImage>
    var closestMatchName: Observable<String>
    var emotionName: Observable<String>
    var emoji: Observable<String>
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType, data: ComparedData, response: CompareResponse) {
        print("distances check: \(response.distances.map { $0.name} )")
        self.sceneCoordinator = sceneCoordinator
        self.originalPhotoImage = .just(data.original_image ?? Appearance.Image.placeholder!)
        self.thumbnailPhotoData = .just(response.distances.map { UIImage(base64: $0.image, withPrefix: false) ?? Appearance.Image.placeholder! })
        
        
        self.closestMatchName = .just(response.closest_match)
        self.emotionName = .just(response.emotion)
        self.emoji = .just(response.emotion.toEmoji())
    }
}
