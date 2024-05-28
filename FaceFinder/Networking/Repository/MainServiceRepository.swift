//
//  MainServiceRepository.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Foundation
import RxSwift

protocol MainServiceRepository {
    
    func sendImage(with request: CompareRequest) -> Observable<Result<CompareResponse, FaceFinder.NetworkError>>
}
