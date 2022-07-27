//
//  RequestInterceptor.swift
//  titan-ios
//
//  Created by Akhrorkhuja on 21/06/22.
//

import Alamofire

final class RequestInterceptor: Alamofire.RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }

}
