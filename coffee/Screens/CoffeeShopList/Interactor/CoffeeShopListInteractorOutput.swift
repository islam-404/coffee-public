//
//  CoffeeShopListInteractorOutput.swift
//  coffee
//
//  Created islam on 09.11.2024.
//

protocol CoffeeShopListInteractorOutput: AnyObject {
    func didFetchCoffeeShops(_ coffeeShops: [CoffeeShopModel])
    func didFetchLocation(latitude: Double, longitude: Double)
}
