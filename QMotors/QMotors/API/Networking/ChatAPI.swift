//
//  ChatAPI.swift
//  QMotors
//
//  Created by Mavlon on 06/09/22.
//

import Foundation
import Alamofire
import SwiftyJSON

final class ChatAPI {
    
    static func getMessages(success: @escaping ([Message]) -> Void, failure: @escaping escapeNetworkError) {
        
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .messages, parameters: params) { data in
            
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                let decoder = JSONDecoder()
                let result = try! decoder.decode(MessagesResponse.self, from: data)
                guard let messages = result.result else { return }
                success(messages)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
            
        } failure: { error in
            failure(error)
        }
    }
    
    static func sendMessage(fileType: FileType, message: String, fileUrlArray: [URL], success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError) {
        
        BaseAPI.authorizedMultipartPostRequestChatFile(fileType: fileType, message: message, fileUrlArray: fileUrlArray) { data in
            
            guard let data = data else { return }
            
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            
            if errors.type == .null {
                success(jsonData["result"])
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
            
        } failure: { error in
            failure(error)
        }
    }
    
    static func sendOnly(message: String, success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError) {
        
        let params: Parameters = ["message": message]
        
        BaseAPI.authorizedPostRequest(reqMethod: .sendOnlyMessage, parameters: params) { data in
            
            guard let data = data else { return }
            
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            
            if errors.type == .null {
                success(jsonData["result"])
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
            
        } failure: { error in
            failure(error)
        }

        
    }
}
