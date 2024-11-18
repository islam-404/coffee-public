//
//  AuthorizationInputModel.swift
//  coffee
//
//  Created islam on 03.11.2024.
//

struct AuthorizationInputModel {
    
    let delegate: AuthorizationScreenDelegate
    let authorizationDelegate: AuthorizationMode
    
    func performAuthorizationAction(data: LoginResponse) {
        switch authorizationDelegate {
        case .newToken:
            delegate.didSuccessAuthorization(data: data)
        case .updateToken:
            delegate.didSuccessUpdateToken(data: data)
        }
    }
    
    enum AuthorizationMode {
        case newToken
        case updateToken
    }
}
