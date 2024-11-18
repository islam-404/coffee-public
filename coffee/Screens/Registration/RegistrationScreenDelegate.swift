//
//  RegistrationScreenDelegate.swift
//  coffee
//
//  Created by islam on 17.11.2024.
//

protocol RegistrationScreenDelegate {
    func didSuccessAuthorization(data: LoginResponse)
    func openAuthorizationScreen()
}
