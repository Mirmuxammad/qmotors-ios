//
//  ArticlesResponce.swift
//  QMotors
//
//  Created by Александр Гужавин on 31.08.2022.
//

import Foundation

struct ArticlesResponce: Codable {
    let result: [Article]?
    let error: CustomError?
}

struct ArticleResponce: Codable {
    let result: Article?
    let error: CustomError?
}

struct Article: Codable {
    let id: Int
    let title: String
    let subtitle: String
    let preview: String
    let created_at: String
    let updated_at: String
    let text: String?
    let previewPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case preview
        case created_at
        case updated_at
        case text
        case previewPath = "preview_path"
    }
}
