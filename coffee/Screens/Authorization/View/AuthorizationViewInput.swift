//
//  AuthorizationViewInput.swift
//  coffee
//
//  Created islam on 03.11.2024.
//

//import DataConverterUtilites

protocol AuthorizationViewInput: AnyObject {
    func setupInitialState()
    func updateData(data: CollectionViewModel)
}
