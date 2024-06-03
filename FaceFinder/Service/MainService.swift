//
//  MainService.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Moya
import RxSwift

class MainService: MainServiceRepository {
    
    
    // MARK: - Private -
    
    private let network: FFNetworking
    private let disposeBag: DisposeBag
    
    init(network: FFNetworking = FFNetworking()) {
        self.network = network
        self.disposeBag = DisposeBag()
    }
    
    func sendImage(with request: CompareRequest) -> RxSwift.Observable<Result<CompareResponse, FaceFinder.NetworkError>> {
        return network.request(target: MultiTarget(NetworkService.sendFile(request: request)))
            .map { try $0.mapJSON() as! CompareResponse  }
            .asObservable()
            .map(Result<CompareResponse, FaceFinder.NetworkError>.success)
            .catch { error in
                guard let error = error as? FaceFinder.NetworkError else { return .just(.failure(.ERR_DB_NO_DATA))}
                return .just(.failure(error))
            }
    }
    
    
    func sendTest(with request: TestRequest) -> Observable<Result<TestResponse, FaceFinder.NetworkError>> {
        return network.request(target: MultiTarget(NetworkService.sendTest(request: request)))
            .map { try $0.map(TestResponse.self)  }
            .asObservable()
            .map(Result<TestResponse, FaceFinder.NetworkError>.success)
            .catch { error in
                guard let error = error as? FaceFinder.NetworkError else { return .just(.failure(.ERR_DB_NO_DATA))}
                return .just(.failure(error))
            }
    }
}
