//
//  CoffeeShopListViewInput.swift
//  coffee
//
//  Created islam on 09.11.2024.
//

//import DataConverterUtilites

protocol CoffeeShopListViewInput: AnyObject {
    func setupInitialState()
    func updateData(data: CollectionViewModel)
}
