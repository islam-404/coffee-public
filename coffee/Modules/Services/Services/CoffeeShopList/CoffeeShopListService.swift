//
//  CoffeeShopListService.swift
//  coffee
//
//  Created by islam on 11.11.2024.
//

protocol CoffeeShopListServiceProtocol {
    func getList(completion: @escaping (Result<[CoffeeShopModel], ServerErrorCustom>) -> Void)
}

struct CoffeeShopListService: CoffeeShopListServiceProtocol {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    public func getList(completion: @escaping (Result<[CoffeeShopModel], ServerErrorCustom>) -> Void) {
        
        networkManager.send(request: CoffeeShopListEndpoint.getList, completion: completion)
    }
}
