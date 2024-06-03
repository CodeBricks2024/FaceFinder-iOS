//
//  NetworkHandler.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Moya
import RxSwift
import Toaster

typealias FFNetworking = Networking<MultiTarget>

final class Networking<Target: TargetType>: MoyaProvider<Target> {
    
    // MARK: - Init -
    
    init() {
        let session = MoyaProvider<Target>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 20
        super.init()
    }
    
    func request(target: Target, file: StaticString = #file, functinos: StaticString = #function, line: UInt = #line) -> Single<Response> {
        
        let requestString = "\(target.method.rawValue), \(target.path), \(target.task)"
        
        return self.rx.request(target)
            .filterSuccessfulStatusCodes()
            .do(onSuccess: { value in
                debugPrint("[SUCCESS]: \(requestString), \(value.statusCode)")
            }, onError: { error in
                debugPrint("[ERROR]: \(error)")
                let message = error.localizedDescription
                Toast(text: message).show()
                
                if let response = (error as? MoyaError)?.response {
                    if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                        let failureMesssage = "[FAILURE]: \(requestString), \(response.statusCode), \(jsonObject)"
                        debugPrint("[MoyaError]: \(message)\n\(failureMesssage)")
                    } else if let rawString = String(data: response.data, encoding: .utf8) {
                        let message = "[FAILURE]: \(requestString), \(response.statusCode), \(rawString)"
                        debugPrint(message)
                    }
                }
            }
        )
    }
}
