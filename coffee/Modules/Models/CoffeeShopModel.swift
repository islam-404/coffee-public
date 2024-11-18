//
//  CoffeeShopModel.swift
//  coffee
//
//  Created by islam on 11.11.2024.
//

import Foundation

struct CoffeeShopModel: Decodable {
    let id: Int
    let name: String
    var point: LocationPoint
}

final class LocationPoint: Decodable {
    let latitude: String
    let longitude: String
    
    private var calculatedDistance: Double?
    
    init(latitude: String, longitude: String, calculatedDistance: Double? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.calculatedDistance = calculatedDistance
    }
    
    var distance: Double? {
        get { calculatedDistance }
        set { calculatedDistance = newValue }
    }
}
