//
//  LoginAPI.swift
//  QMotors
//
//  Created by Akhrorkhuja on 27/07/22.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias escapeJSON = (JSON?) -> Void
typealias escapeNetworkError = (NetworkError?) -> Void

final class LoginAPI {
    static func loginWithSmsCode(phone: String, smsCode: Int, success: @escaping escapeJSON, failure: @escaping escapeNetworkError) {
        let params: Parameters = [
            "phone_number": "\(phone)",
            "sms_code": smsCode
        ]
        
        BaseAPI.unAuthorizedPostRequest(reqMethod: .loginWithSmsCode, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                let token = jsonData["result"]["token"].stringValue
                UserDefaultsService.sharedInstance.authToken = token
                success(jsonData["result"])
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func sendSmsCode(phone: String, success: @escaping escapeJSON, failure: @escaping escapeNetworkError) {
        let params: Parameters = [
            "phone_number": "\(phone)",
        ]
        
        BaseAPI.unAuthorizedPostRequest(reqMethod: .sendSmsCode, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                success(jsonData["result"])
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
}
