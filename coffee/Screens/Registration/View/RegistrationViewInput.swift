//
//  RegistrationViewInput.swift
//  coffee
//
//  Created islam on 17.11.2024.
//

protocol RegistrationViewInput: AnyObject {
    func setupInitialState()
    func updateData(data: CollectionViewModel)
}
