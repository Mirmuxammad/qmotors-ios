//
//  CarAPI.swift
//  QMotors
//
//  Created by Akhrorkhuja on 27/07/22.
//

import Foundation
import SwiftyJSON
import Alamofire

enum CarStatus: Int {
    case active = 0
    case sold = 1
    case deleted = 2
}

final class CarAPI {
    static func carMarkList(success: @escaping ([CarMark]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .carMarkList, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var carMarks: [CarMark] = []
                for carMark in jsonData["result"].arrayValue {
                    carMarks.append(CarMark(id: carMark["id"].intValue, name: carMark["name"].stringValue))
                }
                success(carMarks)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func carModelList(success: @escaping ([CarModel]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .carModelList, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var carModels: [CarModel] = []
                for carModel in jsonData["result"].arrayValue {
                    carModels.append(CarModel(id: carModel["id"].intValue, name: carModel["name"].stringValue))
                }
                success(carModels)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func getMyCars(success: @escaping ([MyCarModel]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .getMyCars, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var myCarModels = [MyCarModel]()
                for myCarModel in jsonData["result"].arrayValue {
                    var carPhotos: [CarPhoto] = []
                    if myCarModel["user_car_photos"].arrayValue.count > 0 {
                        for carPhoto in myCarModel["user_car_photos"].arrayValue {
                            let carPhotoModel = CarPhoto(id: carPhoto["id"].intValue,
                                                         user_car_id: carPhoto["user_car_id"].intValue,
                                                         photo: carPhoto["photo"].stringValue,
                                                         created_at: carPhoto["created_at"].stringValue,
                                                         updated_at: carPhoto["updated_at"].stringValue)
                            carPhotos.append(carPhotoModel)
                        }
                    }

                    myCarModels.append(MyCarModel(id: myCarModel["id"].intValue,
                                                  car_model_id: myCarModel["car_model_id"].intValue,
                                                  user_id: myCarModel["user_id"].intValue,
                                                  year: myCarModel["year"].intValue,
                                                  status: myCarModel["status"].intValue,
                                                  last_visit: myCarModel["last_visit"].stringValue,
                                                  vin: myCarModel["vin"].stringValue,
                                                  mileage: myCarModel["mileage"].stringValue,
                                                  created_at: myCarModel["created_at"].stringValue,
                                                  updated_at: myCarModel["updated_at"].stringValue,
                                                  number: myCarModel["number"].stringValue,
                                                  user_car_photos: carPhotos.count == 0 ? nil : carPhotos,
                                                  model: myCarModel["model"]["name"].stringValue,
                                                  mark: myCarModel["model"]["mark"]["name"].stringValue))
                }
                success(myCarModels)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    
    static func carModelListByMarkId(markId: Int, success: @escaping ([CarModel]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [
            "car_mark_id": markId
        ]
        
        BaseAPI.authorizedGetRequest(reqMethod: .carModelList, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var carModels: [CarModel] = []
                for carModel in jsonData["result"].arrayValue {
                    carModels.append(CarModel(id: carModel["id"].intValue, name: carModel["name"].stringValue))
                }
                success(carModels)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func addCar(carModelId: Int, year: Int, mileage: Int, number: String, vin: String, lastVisit: Date, status: CarStatus, success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let lastVisitStr = formatter.string(from: lastVisit)
        
        let params: Parameters = [
            "car_model_id": carModelId,
            "year": year,
            "mileage": mileage,
            "number": number,
            "vin": vin,
            "last_visit": lastVisitStr,
            "status": status.rawValue
        ]
        
        BaseAPI.authorizedPostRequest(reqMethod: .addCar, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                success(jsonData["result"])
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func editCar(carId: Int, carModelId: Int, year: Int, mileage: Int, number: String, vin: String, lastVisit: Date, status: CarStatus, success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let lastVisitStr = formatter.string(from: lastVisit)
        
        let params: Parameters = [
            "car_model_id": carModelId,
            "year": year,
            "mileage": mileage,
            "number": number,
            "vin": vin,
            "last_visit": lastVisitStr,
            "status": status.rawValue
        ]
        
        BaseAPI.authorizedPutRequest(reqMethod: .editCar(carId), parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                success(jsonData["result"])
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func deleteCar(carId: Int, status: CarStatus, success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError) {

        let params: Parameters = [
            "status": status.rawValue
        ]
        
        BaseAPI.authorizedDeleteRequest(reqMethod: .editCar(carId), parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                success(jsonData["result"])
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    
    
    static func addCarPhoto(carId: Int, fileURLArray: [URL], success: @escaping (JSON) -> Void, failure: @escaping escapeNetworkError) {
        BaseAPI.authorizedMultipartPostRequest(carId: carId, fieldName: "photo", fileURLArray: fileURLArray, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                success(jsonData["result"])
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
}
