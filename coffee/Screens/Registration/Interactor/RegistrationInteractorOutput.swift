//
//  RegistrationInteractorOutput.swift
//  coffee
//
//  Created islam on 17.11.2024.
//

protocol RegistrationInteractorOutput: AnyObject {
    func didSuccessfullyAuthorization(data: LoginResponse)
    func showEmailWarning(_ text: String)
    func showPasswordWarning(_ text: String)
    func showConfirmPasswordWarning(_ text: String)
}
