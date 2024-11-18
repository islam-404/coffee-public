//
//  ProductsEndpoint.swift
//  coffee
//
//  Created by islam on 13.11.2024.
//

import Alamofire

enum ProductsEndpoint: NetworkRequest {
    
    typealias Response = [ProductModel]
    
    case getProducts(coffeeShopId: Int)
    
    var isTokenRequired: Bool { true }
    
    var path: String {
        
        switch self {
        case .getProducts(let coffeeShopId):
            return "/location/\(coffeeShopId)/menu"
        }
    }
    
    var method: HTTPMethod { .get }
}
