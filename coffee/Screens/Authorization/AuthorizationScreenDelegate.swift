//
//  AuthorizationDelegate.swift
//  coffee
//
//  Created by islam on 11.11.2024.
//

import Foundation

protocol AuthorizationScreenDelegate {
    func didSuccessAuthorization(data: LoginResponse)
    func didSuccessUpdateToken(data: LoginResponse)
    func openRegisterScreen()
}
