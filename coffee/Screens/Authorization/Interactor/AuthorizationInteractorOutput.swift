//
//  AuthorizationInteractorOutput.swift
//  coffee
//
//  Created islam on 03.11.2024.
//

protocol AuthorizationInteractorOutput: AnyObject {
    func didSuccessfullyAuthorization(data: LoginResponse)
    func showEmailWarning(_ text: String)
    func showPasswordWarning(_ text: String)
}
