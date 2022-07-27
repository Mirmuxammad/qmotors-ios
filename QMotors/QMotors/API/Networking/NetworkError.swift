//
//  NetworkError.swift
//  titan-ios
//
//  Created by Akhrorkhuja on 21/06/22.
//

import Foundation

enum NetworkErrorType {
    case server
    case decoding
    case other(String)
}

struct NetworkError: Error {
    let type: NetworkErrorType
    let code: Int?
    let status: Int?
    let message: String?
}

extension NetworkError {
    init(_ type: NetworkErrorType, code: Int? = nil, status: Int? = nil) {
        self.type = type
        self.code = code
        self.status = status
        
        switch type {
            case .server: message = "Ошибка сервера: \(code ?? 0)"
            case .decoding: message = "Ошибка декодинга"
            case .other(let text): message = "\(text)"
        }
    }
}
