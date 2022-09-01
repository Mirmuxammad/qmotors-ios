//
//  HelpResponce.swift
//  QMotors
//
//  Created by Руслан Штыбаев on 01.09.2022.
//

import Foundation

struct HelpResponse: Codable {
    let result: HelpResult?
    let error: CustomError?
}

struct HelpResult: Codable {
    let id: Int
    let title, text: String
}
