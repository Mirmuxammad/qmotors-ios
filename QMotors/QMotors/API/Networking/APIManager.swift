//
//  APIManager.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 19.07.22.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    let sessionManager: Session = {
      let configuration = URLSessionConfiguration.af.default
      configuration.requestCachePolicy = .returnCacheDataElseLoad
      let responseCacher = ResponseCacher(behavior: .modify { _, response in
        let userInfo = ["date": Date()]
        return CachedURLResponse(
          response: response.response,
          data: response.data,
          userInfo: userInfo,
          storagePolicy: .allowed)
      })

      let networkLogger = APINetworkLogger()
      let interceptor = APIRequestInterceptor()

      return Session(
        configuration: configuration,
        interceptor: interceptor,
        cachedResponseHandler: responseCacher,
        eventMonitors: [networkLogger])
    }()
    
    
    func sendSmsCode(phoneNumber: String, completion: @escaping (SmsResponse) -> Void) {
        sessionManager.request(APIRouter.sendSmsCode(phoneNumber))
            .responseDecodable(of: SmsResponse.self) { response in
                if let smsResponse = response.value {
                    completion(smsResponse)
                }
            }
    }
    
    func fetchAuthResponse(phoneNumber: String, smsCode: String, completion: @escaping (AuthResponse) -> Void) {
        sessionManager.request(APIRouter.loginWithSmsCode(phoneNumber, smsCode))
            .responseDecodable(of: AuthResponse.self) { response in
                if let authResponse = response.value {
                    completion(authResponse)
                }
            }
    }
    
    
    
    
}

