//
//  CoffeeShopListEndpoint.swift
//  coffee
//
//  Created by islam on 11.11.2024.
//

import Alamofire

enum CoffeeShopListEndpoint: NetworkRequest {
    
    typealias Response = [CoffeeShopModel]
    
    case getList
    
    var isTokenRequired: Bool { true }
    
    var path: String { "/locations" }
    
    var method: HTTPMethod { .get }
}
