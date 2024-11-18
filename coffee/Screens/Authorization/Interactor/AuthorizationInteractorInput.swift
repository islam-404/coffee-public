//
//  AuthorizationInteractorInput.swift
//  coffee
//
//  Created islam on 03.11.2024.
//

protocol AuthorizationInteractorInput {
    func login(login: String, passwod: String)
    func validateEmail(_ email: String) -> String?
    func validatePassword(_ password: String) -> String?
}
