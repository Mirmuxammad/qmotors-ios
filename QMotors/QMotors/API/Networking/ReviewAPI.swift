//
//  ReviewAPI.swift
//  QMotors
//
//  Created by Александр Гужавин on 26.08.2022.
//

import Foundation
import Alamofire

final class ReviewAPI {
    static func show(reviewId: Int, success: @escaping (Review) -> Void, failure: @escaping escapeNetworkError) {
        
        let parameters: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .showReview(reviewId), parameters: parameters) { data in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let result = try! decoder.decode(ReviewResponce.self, from: data)
            guard let review = result.result else { return }
            success(review)
        } failure: { error in
            failure(error)
        }

    }
    
    static func listTechCenters(centerId: Int, success: @escaping ([Review]) -> Void, failure: @escaping escapeNetworkError) {
        
        let parameters: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .listTechCenters(centerId), parameters: parameters) { data in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let result = try! decoder.decode(ListTechCentersResponce.self, from: data)
            guard let list = result.result.first, let reviews = list?.reviews else {
                success([Review]())
                return }
            success(reviews)
        } failure: { error in
            failure(error)
        }

    }
    
    
}
