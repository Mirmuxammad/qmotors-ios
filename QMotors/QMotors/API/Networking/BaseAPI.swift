//
//  BaseAPI.swift
//  titan-ios
//
//  Created by Akhrorkhuja on 21/06/22.
//

import Alamofire
import Foundation
import SwiftyJSON

enum RequestMethod: String {
    case loginWithSmsCode = "login"
    case sendSmsCode = "send-sms-code"
    case profile = "profile"
    case userAutos = "profile/autos"
    case carMarkList = "car-mark/list"
    case carModelList = "car-model/list"
}

final class BaseAPI {
    
    static let baseURL: String = "http://89.223.65.138/api/"
    static let authorizedSession = Session(interceptor: RequestInterceptor())
    
    private let headers: HTTPHeaders = {
        var headers = ["Content-Type": "application/json"]
        return HTTPHeaders(headers)
    }()
    
    fileprivate static func request(reqMethod: RequestMethod,
                                    parameters: Parameters,
                                    method: HTTPMethod,
                                    isAuthorized: Bool,
                                    success: @escaping (Data?) -> Void,
                                    failure: @escaping (NetworkError?) -> Void) {
        var headers = BaseAPI().headers
        
        if isAuthorized {
//            guard let token = UserDefaultsService.sharedInstance.authToken else {
//                failure(NetworkError(.other("Токен не найден!")))
//                return
//            }
            headers.add(.authorization(bearerToken: "111|SYBnB7NDu2XgsMGTQmqyo5NdRNy88On9gOUKkceN"))
        }
        
        authorizedSession.request(URL(string: BaseAPI.baseURL + reqMethod.rawValue)!, method: method, parameters: parameters, headers: headers).response { response in
//            print("ReqMethod: \(reqMethod.rawValue)\nJSON Status: \(String(describing: response.response?.statusCode))\nResponse:", JSON(response.data ?? ""))
            if let data = response.data {
                success(data)
            } else {
                failure(NetworkError(.server, code: response.response?.statusCode))
            }
        }
    }
    
    // MARK: GET Requests
    static func unAuthorizedGetRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .get, isAuthorized: false, success: success, failure: failure)
    }
    
    static func authorizedGetRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .get, isAuthorized: true, success: success, failure: failure)
    }
    
    // MARK: POST Requests
    static func unAuthorizedPostRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .post, isAuthorized: false, success: success, failure: failure)
    }
    
    static func authorizedPostRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .post, isAuthorized: true, success: success, failure: failure)
    }
}
