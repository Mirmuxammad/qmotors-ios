//
//  MessagesResponse.swift
//  QMotors
//
//  Created by Mavlon on 06/09/22.
//

import Foundation

struct MessagesResponse: Codable {
    let result: [Message]?
    let error: CustomError?
}

struct Message: Codable {
    let message: String
    let created_at: String
    let admin_user_id: Int?
    let user_id: Int?
    let video: String?
    let photo: String?
    let file: String?
    
    var filetype: FileType {
        if let _ = file {
            return FileType.file
        } else if let _ = photo {
            return FileType.photo
        } else if let _ = video {
            return FileType.video
        } else {
            return FileType.none
        }
    }
}

enum FileType: Codable {
    case file,video,photo,none
}
