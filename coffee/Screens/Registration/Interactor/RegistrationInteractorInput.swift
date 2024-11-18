//
//  RegistrationInteractorInput.swift
//  coffee
//
//  Created islam on 17.11.2024.
//

protocol RegistrationInteractorInput {
    func register(login: String, password: String, confirmPassword: String)
    func validateEmail(_ email: String) -> String?
    func validatePassword(password: String) -> String?
}
