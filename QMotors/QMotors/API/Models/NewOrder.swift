//
//  NewOrder.swift
//  QMotors
//
//  Created by Александр Гужавин on 09.08.2022.
//

import Foundation

struct OrderResponse: Codable {
    let errors: CustomError?
    let result: OrderNet
}

struct OrderNet: Codable {
    let orderTypeID, techCenterID: Int?
        let resultDescription: String?
        let date: String?
        let guarantee: Bool?
        let userCarID, id: Int?
        let orderNumber: Int?
        let updatedAt, createdAt: String?

        enum CodingKeys: String, CodingKey {
            case orderTypeID = "order_type_id"
            case techCenterID = "tech_center_id"
            case resultDescription = "description"
            case date, guarantee
            case userCarID = "user_car_id"
            case id
            case orderNumber = "order_number"
            case updatedAt = "updated_at"
            case createdAt = "created_at"
        }
}

struct NewOrder {
    var carId: String?
    var carNumber: String?
    var orderTypeId: Int?
    var techCenterId: Int?
    var guarantee: Bool?
    var date: String?
    var description: String?
}
