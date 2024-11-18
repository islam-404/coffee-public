//
//  ProductsService.swift
//  coffee
//
//  Created by islam on 13.11.2024.
//

import Foundation

protocol ProductsServiceProtocol {
    func getProducts(coffeeShopId: Int, completion: @escaping (Result<[ProductModel], ServerErrorCustom>) -> Void)
}

final class ProductsService {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension ProductsService: ProductsServiceProtocol {
    
    func getProducts(coffeeShopId: Int, completion: @escaping (Result<[ProductModel], ServerErrorCustom>) -> Void) {
        
        networkManager.send(request: ProductsEndpoint.getProducts(coffeeShopId: coffeeShopId), completion: completion)
    }
}
