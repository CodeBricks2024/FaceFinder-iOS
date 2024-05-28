//
//  MainServiceRepository.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Foundation
import RxSwift

protocol MainServiceRepository {
    
    func sendImage(with request: String) -> Observable<Result<String, FaceFinder.NetworkError>>
}
