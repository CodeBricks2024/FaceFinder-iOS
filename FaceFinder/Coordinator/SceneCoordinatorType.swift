//
//  SceneCoordinatorType.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {
    
    init(window: UIWindow)
    
    @discardableResult
    func transition(to scene: TargetScene) -> Observable<Void>
    
    @discardableResult
    func pop(animated: Bool) -> Observable<Void>
    
    @discardableResult
    func dismiss(animated: Bool) -> Completable
}
