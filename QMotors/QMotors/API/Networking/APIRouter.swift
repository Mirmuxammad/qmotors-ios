//
//  APIRouter.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 19.07.22.
//

import Foundation
import Alamofire

enum APIRouter {
    case loginWithSmsCode(String, String)
    case sendSmsCode(String)
    case fetchProfile
    case fetchUserAutos
    
    var path: String {
        switch self {
        case .loginWithSmsCode:
            return "/api/login"
        case .sendSmsCode:
            return "/api/send-sms-code"
        case .fetchProfile:
            return "/api/profile"
        case .fetchUserAutos:
            return "/api/profile/autos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .loginWithSmsCode, .sendSmsCode:
            return .post
        case .fetchProfile, .fetchUserAutos:
            return .get
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .loginWithSmsCode(let phoneNumber, let smsCode):
            return [
                "phone_number": phoneNumber,
                "sms_code": smsCode
            ]
        case .sendSmsCode(let phoneNumber):
            return ["phone_number": phoneNumber]
        case .fetchProfile:
            return nil
        case .fetchUserAutos:
            return nil
        }
    }
}

// MARK: - URLRequestConvertible
extension APIRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try APIConstants.baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        if method == .get {
            request = try URLEncodedFormParameterEncoder()
                .encode(parameters, into: request)
        } else if method == .post {
            request = try JSONParameterEncoder().encode(parameters, into: request)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        return request
    }
}
