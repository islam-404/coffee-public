//
//  AuthService.swift
//  Services
//
//  Created by islam on 06.11.2024.
//

import Foundation

protocol AuthServiceProtocol {
    func login(login: String, password: String, completion: @escaping (Result<LoginResponse, ServerErrorCustom>) -> Void)
    func register(login: String, password: String, completion: @escaping (Result<LoginResponse, ServerErrorCustom>) -> Void)
}

struct AuthService: AuthServiceProtocol {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func login(login: String, password: String, completion: @escaping (Result<LoginResponse, ServerErrorCustom>) -> Void) {
        networkManager.send(request: AuthorizationEndpoint.login(login: login, password: password), completion: completion)
    }
    
    func register(login: String, password: String, completion: @escaping (Result<LoginResponse, ServerErrorCustom>) -> Void) {
        networkManager.send(request: AuthorizationEndpoint.register(login: login, password: password), completion: completion)
    }
}
