//
//  SmsResponse.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 19.07.22.
//

import Foundation

// MARK: - SmsResponse
struct SmsResponse: Codable {
    let result: String
    let error: CustomError?
}
