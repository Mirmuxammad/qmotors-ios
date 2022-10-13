//
//  AuthResponse.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 19.07.22.
//

import Foundation

// MARK: - AuthResponse
struct AuthResponse: Codable {
    let result: AuthResult?
    let error: CustomError?
}

// MARK: - Result
struct AuthResult: Codable {
    let user: User
    let token: String
}
// MARK: - Response

struct ProfileResponse: Codable {
    let result: User
    let error: CustomError?
}

// MARK: - User
struct User: Codable {
    let id: Int
    let encryptedPassword, phoneNumber: String
    let email: String?
    let isComplete: Bool
    let resetPasswordToken, resetPasswordSentAt, rememberCreatedAt: String?
    let createdAt, updatedAt: String
    let avatar, surname, name, patronymic: String?
    let gender: Int
    let birthday, additionalPhoneNumber: String?
    let agreeNotification, agreeSMS, agreeCalls, agreeData: Bool
    let deviceToken: String?
    let newApp: Bool
    let smsCode: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case encryptedPassword = "encrypted_password"
        case phoneNumber = "phone_number"
        case isComplete = "is_complete"
        case resetPasswordToken = "reset_password_token"
        case resetPasswordSentAt = "reset_password_sent_at"
        case rememberCreatedAt = "remember_created_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case avatar, surname, name, patronymic, gender, birthday
        case additionalPhoneNumber = "additional_phone_number"
        case agreeNotification = "agree_notification"
        case agreeSMS = "agree_sms"
        case agreeCalls = "agree_calls"
        case agreeData = "agree_data"
        case deviceToken = "device_token"
        case newApp = "new_app"
        case smsCode = "sms_code"
    }
}
