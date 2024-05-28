//
//  NetworkService.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Moya

public enum NetworkService {
    case sendFile(request: String)
    
}

extension NetworkService: TargetType {
    
    public var baseURL: URL {
        return URL(string: Constants.API.BASE_URL)!
    }
    
    
    public var path: String {
        switch self {
        case .sendFile: return ""
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var task: Moya.Task {
        switch self {
        case .sendFile(let request):
            return self.requestTask(request)
        }
    }
    
    public func requestTask(_ request: Any) -> Task {
        let requestToJson = JSONSerializer.toJson(request)
        guard let params = requestToJson.jsonStringToDictionary else { return .requestPlain }
        return requestParam(params: params)
    }
    
    public func requestParam(params: [String: Any]) -> Task {
        return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }
    
    public var headers: [String : String]? {
        var httpHeaders: [String: String] = ["Content-type" : "application/json", "AppType": "User"]
        httpHeaders["User-Agent"] = ""
        return httpHeaders
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
