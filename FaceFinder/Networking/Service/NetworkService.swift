//
//  NetworkService.swift
//  FaceFinder
//
//  Created by Songkyung Min on 5/28/24.
//

import Moya

public enum NetworkService {
    case sendFile(request: CompareRequest)
    case sendTest(request: TestRequest)
}

extension NetworkService: TargetType {
    
    public var baseURL: URL {
        return URL(string: Constants.API.BASE_URL)!
    }
    
    public var path: String {
        switch self {
            case .sendFile: return "/compare"
            case .sendTest: return "/test"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var task: Moya.Task {
        switch self {
        case .sendFile(let request):
            let params: [String: Any] = ["image_file": request.image_file]
            var formData = [MultipartFormData]()
            for (key, value) in params {
                if let imgData = value as? URL {
                    formData.append(MultipartFormData(provider: .file(imgData), name: "image", fileName: "user_image.jpg", mimeType: "image/jpg"))
                    print("formdata1: \(formData)")
                } else if let imgData = request.image_file {
                    formData.append(MultipartFormData(provider: .data(imgData), name: "\(key)", fileName: "user_image.jpg", mimeType: "image/jpg"))
                } else {
                    formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: "\(key).jpg", fileName: "user_image.jpg", mimeType: "image/jpg"))
                }
            }
            return .uploadMultipart(formData)
            
            case .sendTest(let request):
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
        var httpHeaders: [String : String] = [:]
        switch self {
            case .sendFile:
                httpHeaders = ["Content-type" : "multipart/form-data", "AppType": "User"]
                httpHeaders["User-Agent"] = ""
            
            case .sendTest:
                httpHeaders = ["Content-type" : "application/json", "AppType": "User"]
                httpHeaders["User-Agent"] = ""
        }
       
        return httpHeaders
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
