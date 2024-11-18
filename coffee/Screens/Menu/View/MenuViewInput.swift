//
//  MenuViewInput.swift
//  coffee
//
//  Created islam on 13.11.2024.
//

//import DataConverterUtilites

protocol MenuViewInput: AnyObject {
    func setupInitialState()
    func updateData(data: CollectionViewModel)
    func showAlertForMismatchedCoffeeShop(completion: @escaping ((Bool) -> ()))
}
