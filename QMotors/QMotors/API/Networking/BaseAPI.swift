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
    case postProfile
    case userAutos
    case carMarkList
    case carModelList
    case addCar
    case addCarPhoto(Int)
    case getTechCenterList
    case getMyCars
    case editCar(Int)
    case deletePhoto(Int)
    case orderTypeList
    case order
    case orderPhoto(Int)
    case orderList(Int)
    case bonus
    case notification
    case review
    case showReview(Int)
    case listTechCenters(Int)
    case reminder
    case getReminder
    case deleteReminder(Int)
    case editReminder(Int)
    case faq
    case articles
    case articleDeteil(Int)
    case messages
    case sendMessage(String)
    case sendOnlyMessage
    
    var path: String {
        switch self {
        case .loginWithSmsCode:
            return "login"
        case .sendSmsCode:
            return "send-sms-code"
        case .profile:
            return "profile"
        case .postProfile:
            return "profile/update"
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
        case .getMyCars:
            return "car"
        case .editCar(let id):
            return "car/\(id)"
        case .deletePhoto(let id):
            return "car/photo/\(id)"
        case .orderTypeList:
            return "order-type/list"
        case .order:
            return "order"
        case .orderPhoto(let id):
            return "order/\(id)/photo"
        case .orderList(let id):
            return "order/history?user_car_id=\(id)"
        case .bonus:
            return "bonus"
        case .notification:
            return "notification"
        case .review:
            return "review"
        case .showReview(let id):
            return "review/\(id)"
        case .listTechCenters(let id):
            return "review?tech_center_id=\(id)"
        case .reminder:
            return "reminder"
        case .getReminder:
            return "reminder"
        case .deleteReminder(let id):
            return "reminder/\(id)"
        case .editReminder(let id):
            return "reminder/\(id)"
        case .faq:
            return "help"
        case .articles:
            return "article"
        case .articleDeteil(let id):
            return "article/\(id)"
        case .messages:
            return "chat/messages"
        case .sendMessage(let message):
            return "chat?message=\(message)"
        case .sendOnlyMessage:
            return "chat"
        }
    
    }
}

final class BaseAPI {
    
    static let baseURL: String = "http://89.223.65.138"
    static let baseAPIURL: String = "http://89.223.65.138/api/"
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
        
        var encoding: ParameterEncoding!
        switch method {
        case .get:
            encoding = URLEncoding.default
            break
        case .post, .put, .delete:
            encoding = JSONEncoding.default
            break
        default:
            encoding = URLEncoding.default
            break
        }
        
        authorizedSession.request(URL(string: BaseAPI.baseAPIURL + reqMethod.path)!, method: method, parameters: parameters, encoding: encoding, headers: headers).response { response in
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
        
        for fileURL in fileURLArray {
            if let fileData = try? Data(contentsOf: fileURL) {
                authorizedSession.upload(multipartFormData: { multiPart in
                    multiPart.append(fileData,
                                     withName: fieldName,
                                     fileName: fileURL.lastPathComponent,
                                     mimeType: "image/jpeg")
                    
                    
                }, to: BaseAPI.baseAPIURL + reqMethod.path, method: .post, headers: headers).response { response in
                    debugPrint(response)
                    if let data = response.data {
                        success(data)
                    } else {
                        failure(NetworkError(.server, code: response.response?.statusCode))
                    }
                }
            }
            
        }
    }
    
    fileprivate static func requestChatFile(reqMethod: RequestMethod,
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
        
        for fileURL in fileURLArray {
            if let fileData = try? Data(contentsOf: fileURL) {
                authorizedSession.upload(multipartFormData: { multiPart in
                    multiPart.append(fileData,
                                     withName: fieldName,
                                     fileName: fileURL.lastPathComponent,
                                     mimeType: fileURL.mimeType())
                    
                    
                }, to: BaseAPI.baseAPIURL + reqMethod.path, method: .post, headers: headers).response { response in
                    debugPrint(response)
                    if let data = response.data {
                        success(data)
                    } else {
                        failure(NetworkError(.server, code: response.response?.statusCode))
                    }
                }
            }
            
        }
    }
    
    fileprivate static func userAvatarRequest(reqMethod: RequestMethod,
                                    fieldName: String,
                                    fileURL: URL,
                                    success: @escaping (Data?) -> Void,
                                    failure: @escaping (NetworkError?) -> Void) {
        var headers = BaseAPI().headers
        
        guard let token = UserDefaultsService.sharedInstance.authToken else {
            failure(NetworkError(.other("Токен не найден!")))
            return
        }
        headers.add(.authorization(bearerToken: token))
            if let fileData = try? Data(contentsOf: fileURL) {
                authorizedSession.upload(multipartFormData: { multiPart in
                    multiPart.append(fileData,
                                     withName: fieldName,
                                     fileName: fileURL.lastPathComponent,
                                     mimeType: "image/jpeg")
                    
                    
                }, to: BaseAPI.baseAPIURL + reqMethod.path, method: .post, headers: headers).response { response in
                    debugPrint(response)
                    if let data = response.data {
                        success(data)
                    } else {
                        failure(NetworkError(.server, code: response.response?.statusCode))
                    }
                }
        }
    }
    
    // MARK: GET Requests
    
    // для неавторизованных запросов
    static func unAuthorizedGetRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .get, success: success, failure: failure)
    }
    
    // для авторизованных запросов
    static func authorizedGetRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .get, success: success, failure: failure)
    }
    
    // MARK: POST Requests
    
    // для неавторизованных запросов
    static func unAuthorizedPostRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .post, success: success, failure: failure)
    }
    
    // для авторизованных запросов
    static func authorizedPostRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .post, success: success, failure: failure)
    }
    
    // загрузка фото для авторизованных запросов
    static func authorizedMultipartPostRequest(carId: Int, fieldName: String, fileURLArray: [URL], success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: .addCarPhoto(carId), fieldName: fieldName, fileURLArray: fileURLArray, success: success, failure: failure)
    }
    // загрузка фото для авторизованных пользователей для сервиса
    static func authorizedMultipartPostRequestForOrder(orderId: Int, fieldName: String, fileURLArray: [URL], success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: .orderPhoto(orderId), fieldName: fieldName, fileURLArray: fileURLArray, success: success, failure: failure)
    }
    // загрузка фото пользовотеля
    static func authorizedMultipartPostUserAvatarRequest(userId: Int, fieldName: String, fileURL: URL, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        userAvatarRequest(reqMethod: .postProfile, fieldName: fieldName, fileURL: fileURL, success: success, failure: failure)
    }
    
    // загрузка файла для чат
    static func authorizedMultipartPostRequestChatFile(fileType: FileType, message: String, fileUrlArray: [URL], success: @escaping (Data?) -> Void, failure: @escaping escapeNetworkError) {
        switch fileType {
        case .file:
            requestChatFile(reqMethod: .sendMessage(message), fieldName: "file", fileURLArray: fileUrlArray, success: success, failure: failure)
        case .video:
            requestChatFile(reqMethod: .sendMessage(message), fieldName: "video", fileURLArray: fileUrlArray, success: success, failure: failure)
        case .photo:
            requestChatFile(reqMethod: .sendMessage(message), fieldName: "photo", fileURLArray: fileUrlArray, success: success, failure: failure)
        case .none:
            requestChatFile(reqMethod: .sendMessage(message), fieldName: "", fileURLArray: fileUrlArray, success: success, failure: failure)
        }
    }
    
    // MARK: - PUT Requests
    
    // для авторизованных запросов
    static func authorizedPutRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .put, success: success, failure: failure)
    }
    
    // MARK: - DELETE Requests
    
    // для авторизованных запросов
    static func authorizedDeleteRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .delete, success: success, failure: failure)
    }
    
}
