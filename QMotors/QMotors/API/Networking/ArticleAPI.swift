//
//  ArticleAPI.swift
//  QMotors
//
//  Created by Александр Гужавин on 31.08.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

final class ArticleAPI {
    
    static func getArticles(success: @escaping ([Article]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .articles, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                let decoder = JSONDecoder()
                let result = try! decoder.decode(ArticlesResponce.self, from: data)
                guard let articles = result.result else { return }
                success(articles)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func getArticle(id: Int, success: @escaping (Article) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .articleDeteil(id), parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                let decoder = JSONDecoder()
                let result = try! decoder.decode(ArticleResponce.self, from: data)
                guard let article = result.result else { return }
                success(article)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    
    
}
