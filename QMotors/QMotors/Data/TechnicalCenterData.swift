//
//  TechnicalCenterData.swift
//  QMotors
//
//  Created by Alexey Grebennikov on 28.07.22.
//

import Foundation
import MapKit

struct TechnicalCenter {
    let title: String
    let address: String
    let phoneNumber: String
    let coordinates: CLLocation
}

class TechnicalCenterData {
    
    static let shared = TechnicalCenterData()
    
    private init() {}
    
    let technicalCenters = [
        TechnicalCenter(title: "МИЧУРИНСКИЙ",
                        address: "ул. Удальцова, 60",
                        phoneNumber: "+7 (495) 150-77-21",
                        coordinates: CLLocation(latitude: 55.687771, longitude: 37.488125)),
        TechnicalCenter(title: "СЕВАСТОПОЛЬСКИЙ",
                        address: "Севастопольский пр-т, 95Б с.1",
                        phoneNumber: "+7 (495) 150-70-36",
                        coordinates: CLLocation(latitude: 55.635350, longitude: 37.543578)),
        TechnicalCenter(title: "ДМИТРОВКА",
                        address: "ул. Лобненская, 17 стр 1",
                        phoneNumber: "+7 (495) 150-70-73",
                        coordinates: CLLocation(latitude: 55.891663, longitude: 37.523737)),
        TechnicalCenter(title: "КАЛУЖСКАЯ",
                        address: "Научный проезд, 14А стр.8",
                        phoneNumber: "+7 (495) 374-50-55",
                        coordinates: CLLocation(latitude: 55.655749, longitude: 37.552974))
    ]
    
}
