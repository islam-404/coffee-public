//
//  CoffeeShopMapViewInput.swift
//  coffee
//
//  Created islam on 12.11.2024.
//

//import DataConverterUtilites

protocol CoffeeShopMapViewInput: AnyObject {
    func setupInitialState()
    func updateData(data: CollectionViewModel)
    func setPoints(placemarks: [CoffeeShopModel])
}
