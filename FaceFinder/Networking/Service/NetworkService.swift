//
//  NetworkService.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Moya

public enum NetworkService {
    case sendFile(request: CompareRequest)
}

extension NetworkService: TargetType {
    
    public var baseURL: URL {
        return URL(string: Constants.API.BASE_URL)!
    }
    
    public var path: String {
        switch self {
        case .sendFile: return "/compare"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var task: Moya.Task {
        switch self {
        case .sendFile(let request):
//            return self.requestTask(request)
            let params: [String: Any] = ["image_file":request.image_file ?? nil]
            
            var formData = [MultipartFormData]()
            for (key, value) in params {
                if let imgData = value as? URL {
                    formData.append(MultipartFormData(provider: .file(imgData), name: "image", fileName: "user_image.jpg", mimeType: "image/jpg"))
                } else {
                    formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
                }
            }
            return .uploadMultipart(formData)
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
        var httpHeaders: [String: String] = ["Content-type" : "multipart/form-data", "AppType": "User"]
        httpHeaders["User-Agent"] = ""
        return httpHeaders
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
