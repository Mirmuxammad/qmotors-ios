//
//  CarOrderResponce.swift
//  QMotors
//
//  Created by Александр Гужавин on 11.08.2022.
//

import Foundation

struct CarOrderResponce: Codable {
    let result: [CarOrder]
    let error: CustomError?
}

struct CarOrder: Codable {
    let id: Int
    let car_model_id: Int
    let user_id: Int
    let year: Int
    let status: Int
    let last_visit: String?
    let vin: String?
    let mileage: String
    let created_at: String
    let updated_at: String
    let number: String?
    let orders: [Order]
}

struct Order: Codable {
    let id: Int
    let user_car_id: Int
    let tech_center_id: Int
    let order_id: String?
    let date: String
    let order_type: Int?
    let description: String?
    let guarantee: Bool
    let created_at: String
    let updated_at: String
    let stock_id: Int?
    let mileage: String?
    let order_number: String?
    let status: Int
    let order_type_id: Int
    let free_diagnostics: Bool
    let stock: Stock?
}
