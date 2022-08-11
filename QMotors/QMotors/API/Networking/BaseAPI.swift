//
//  BaseAPI.swift
//  titan-ios
//
//  Created by Akhrorkhuja on 21/06/22.
//

import Alamofire
import Foundation
import SwiftyJSON

enum RequestMethod {
    case loginWithSmsCode
    case sendSmsCode
    case profile
    case userAutos
    case carMarkList
    case carModelList
    case addCar
    case addCarPhoto(Int)
    case getTechCenterList
    case getCars
    case editCar(Int)
    case orderTypeList
    case order
    
    var path: String {
        switch self {
        case .loginWithSmsCode:
            return "login"
        case .sendSmsCode:
            return "send-sms-code"
        case .profile:
            return "profile"
        case .userAutos:
            return "profile/autos"
        case .carMarkList:
            return "car-mark/list"
        case .carModelList:
            return "car-model/list"
        case .addCar:
            return "car"
        case .addCarPhoto(let id):
            return "car/\(id)/photo"
        case .getTechCenterList:
            return "tech-center/list"
        case .getCars:
            return "car"
        case .editCar(let id):
            return "car/\(id)"
        case .orderTypeList:
            return "order-type/list"
        case .order:
            return "order"
        }
    }
}

final class BaseAPI {
    
    static let baseURL: String = "http://89.223.65.138/api/"
    static let authorizedSession = Session(interceptor: RequestInterceptor())
    
    private let headers: HTTPHeaders = {
        var headers = ["Accept": "application/json"]
        return HTTPHeaders(headers)
    }()
    
    fileprivate static func request(reqMethod: RequestMethod,
                                    parameters: Parameters,
                                    method: HTTPMethod,
                                    success: @escaping (Data?) -> Void,
                                    failure: @escaping (NetworkError?) -> Void) {
        var headers = BaseAPI().headers
        
        if let token = UserDefaultsService.sharedInstance.authToken {
            headers.add(.authorization(bearerToken: token))
        }
        
        authorizedSession.request(URL(string: BaseAPI.baseURL + reqMethod.path)!, method: method, parameters: parameters, encoding: method == .post || method == .put || method == .delete ? JSONEncoding.default : URLEncoding.default, headers: headers).response { response in
            debugPrint(response)
            print("ReqMethod: \(reqMethod)\nJSON Status: \(String(describing: response.response?.statusCode))\nResponse:", JSON(response.data ?? ""))
            if let data = response.data {
                success(data)
            } else {
                failure(NetworkError(.server, code: response.response?.statusCode))
            }
        }
    }
    
    fileprivate static func request(reqMethod: RequestMethod,
                                    fieldName: String,
                                    fileURLArray: [URL],
                                    success: @escaping (Data?) -> Void,
                                    failure: @escaping (NetworkError?) -> Void) {
        var headers = BaseAPI().headers
        
        guard let token = UserDefaultsService.sharedInstance.authToken else {
            failure(NetworkError(.other("Токен не найден!")))
            return
        }
        headers.add(.authorization(bearerToken: token))
        
        authorizedSession.upload(multipartFormData: { multiPart in
            print("🔴", fileURLArray)
            for fileURL in fileURLArray {
                if let fileData = try? Data(contentsOf: fileURL) {
                    multiPart.append(fileData, withName: fieldName, fileName: fileURL.lastPathComponent, mimeType: "image/jpeg")
                }
            }
        }, to: BaseAPI.baseURL + reqMethod.path, method: .post, headers: headers).response { response in
            debugPrint(response)
        }
    }
    
    // MARK: GET Requests
    static func unAuthorizedGetRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .get, success: success, failure: failure)
    }
    
    static func authorizedGetRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .get, success: success, failure: failure)
    }
    
    static func getTechCenterList(reqMethod: RequestMethod, parameters: Parameters, success: @escaping(Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .get, success: success, failure: failure)
    }
    
    // MARK: POST Requests
    static func unAuthorizedPostRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .post, success: success, failure: failure)
    }
    
    static func authorizedPostRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .post, success: success, failure: failure)
    }
    
    static func authorizedMultipartPostRequest(carId: Int, fieldName: String, fileURLArray: [URL], success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: .addCarPhoto(carId), fieldName: fieldName, fileURLArray: fileURLArray, success: success, failure: failure)
    }
    //MARK: - Put request
    static func authorizedPutRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .put, success: success, failure: failure)
    }
    
    static func authorizedDeleteRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .delete, success: success, failure: failure)
    }
    
}
