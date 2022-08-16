//
//  ProfileAPI.swift
//  QMotors
//
//  Created by Akhrorkhuja on 27/07/22.
//

import Foundation
import SwiftyJSON
import Alamofire

final class ProfileAPI {
    static func profile(success: @escaping (ProfileResponse) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .profile, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                do {
                    let decoder = JSONDecoder()
                    let userModel = try decoder.decode(ProfileResponse.self, from: data)
                    success(userModel)
                } catch let error {
                    print(error)
                    failure(NetworkError(.decoding))
                }
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func userAutos(success: @escaping escapeJSON, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .userAutos, parameters: params, success: { data in
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
    
    static func postUser(surname: String, name: String,patronymic: String, phoneNumber: String, email: String, brithday: String, gender: Int,agreeNotification: Bool, agreeSms: Bool, agreeCalls: Bool, agreeData: Bool,  success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError){
        let params: Parameters = [
            "surname": surname,
            "name": name,
            "phone_number": phoneNumber,
            "patronymic": patronymic,
            "email": email,
            "birthday": brithday,
            "gender": gender,
            "agree_notification": agreeNotification,
            "agree_sms": agreeSms,
            "agree_calls": agreeCalls,
            "agree_data": agreeData
        ]
        
        BaseAPI.authorizedPostRequest(reqMethod: .postProfile, parameters: params, success: { data in
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
    
    static func addAvatar(userId: Int, fileURL: URL, success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError) {
        
        BaseAPI.authorizedMultipartPostUserAvatarRequest(userId: userId, fieldName: "avatar", fileURL: fileURL, success: { data in
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
