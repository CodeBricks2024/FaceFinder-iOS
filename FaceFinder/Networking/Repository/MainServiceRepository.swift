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
    
    func sendTest(with request: TestRequest) -> Observable<Result<TestResponse, FaceFinder.NetworkError>>
}
