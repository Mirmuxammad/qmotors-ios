//
//  ListTechCentersResponce.swift
//  QMotors
//
//  Created by Александр Гужавин on 26.08.2022.
//

import Foundation

struct ListTechCentersResponce: Codable {
    let result: [TechCentersReviews?]
    let error: CustomError?
}

struct TechCentersReviews: Codable {
    let id: Int
    let title: String
    let address: String
    let phone: String
    let latitude: String
    let longitude: String
    let createdAt: String
    let updatedAt: String
    let url: String
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case address
        case phone
        case latitude = "lat"
        case longitude = "lng"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case url
        case reviews
    }
}
