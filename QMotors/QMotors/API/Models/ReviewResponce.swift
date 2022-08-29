//
//  ReviewResponce.swift
//  QMotors
//
//  Created by Александр Гужавин on 26.08.2022.
//

import Foundation

struct ReviewResponce: Codable {
    let result: Review?
    let error: CustomError?
}

struct Review: Codable {
    let id: Int
    let rating: Int
    let comment: String
    let moderated: Bool
    let orderId: Int
    let createdAt: String
    let updatedAt: String
    let laravelThroughKey: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case rating
        case comment
        case moderated 
        case orderId = "order_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case laravelThroughKey = "laravel_through_key"
    }
}
