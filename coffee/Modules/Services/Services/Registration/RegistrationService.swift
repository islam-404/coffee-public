//
//  RegistrationService.swift
//  Services
//
//  Created by islam on 06.11.2024.
//

import Foundation

public protocol RegistrationServiceProtocol {
    func register(username: String, password: String, confirmPassword: String)
}


public struct RegistrationService: RegistrationServiceProtocol {
    
    public func register(username: String, password: String, confirmPassword: String) {
        
    }
}
