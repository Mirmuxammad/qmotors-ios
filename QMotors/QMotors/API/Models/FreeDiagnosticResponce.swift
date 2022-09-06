//
//  FreeDiagnosticList.swift
//  QMotors
//
//  Created by Руслан Штыбаев on 06.09.2022.
//

import Foundation

struct FreeDiagnosticResponce: Codable {
    let result: [[FreeDiagnosticList]]?
    let errors: CustomError?
}

// MARK: - Result
struct FreeDiagnosticList: Codable {
    let name: String
    let types: [FreeDiagnostic]
}

// MARK: - TypeElement
struct FreeDiagnostic: Codable {
    let name: String
}
