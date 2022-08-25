//
//  Bonus.swift
//  QMotors
//
//  Created by Mavlon on 25/08/22.
//

import Foundation

struct BonusResponse {
    let bonuses: [Bonus]
    let balance: String
    let error: CustomError?
}

struct Bonus {
    let id: Int
    let bonus_type: Int
    let status: Int
    let points: Int
    let title: String
    let remainder: Int
    let user_id: Int
    let created_at: String
    let updated_at: String
}
