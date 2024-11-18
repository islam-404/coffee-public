//
//  AuthorizationEndpoint.swift
//  Services
//
//  Created by islam on 06.11.2024.
//

import Alamofire

enum AuthorizationEndpoint: NetworkRequest {
    
    typealias Response = LoginResponse
    
    case login(login: String, password: String)
    case register(login: String, password: String)
    
    var isTokenRequired: Bool { false }
    
    var path: String {
        
        switch self {
        case .login(let login, let password): "/auth/login"
        case .register(let login, let password): "/auth/register"
        }
    }
    
    var parameters: [String : Any]? {
        
        switch self {
        case .login(let login, let password): ["login": login, "password": password]
        case .register(let login, let password): ["login": login, "password": password]
        }
    }
    
    var method: HTTPMethod { .post }
    
    var encoding: ParameterEncoding { JSONEncoding() }
}
