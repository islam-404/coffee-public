//
//  OrderViewInput.swift
//  coffee
//
//  Created islam on 15.11.2024.
//

//import DataConverterUtilites

protocol OrderViewInput: AnyObject {
    func setupInitialState()
    func updateData(data: CollectionViewModel)
}
