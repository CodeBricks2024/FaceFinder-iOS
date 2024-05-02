//
//  Extensions+ObservableType.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/2/24.
//

import RxSwift
import RxCocoa

extension ObservableType {
    
    func ignoreAll() -> Observable<Void> {
        return map { _ in }
    }
    
    func unwrap<T>() -> Observable<T> where Element == T? {
        return compactMap { $0 }
    }    
}
