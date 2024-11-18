//
//  ValidationService.swift
//  Services
//
//  Created by islam on 09.11.2024.
//

import Foundation

protocol AuthValidationServiceProtocol {
    func validateAuthValidationEmail(_ email: String) throws(AuthorizationValidationError)
    func validateAuthPassword(_ password: String) throws(AuthorizationValidationError)
}

protocol RegistrValidationServiceProtocol {
    func validateRegistrationEmail(_ email: String) throws(RegistrationValidationError)
    func validateRegistrationPassword(_ password: String) throws(RegistrationValidationError)
    func validateRegistrationConfirmPassword(_ password: String, _ confirmPassword: String) throws(RegistrationValidationError)
}

final class ValidationService {
    
    init() {}
    
    private func validateEmail(_ email: String) -> ValidationEmail? {
        if email.isEmpty {
            return .emptyEmail
        }
        
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        
        if !emailPredicate.evaluate(with: email) {
            return .invalidFormatEmail
        }
        
        return nil
    }
    
    enum ValidationEmail {
        case emptyEmail
        case invalidFormatEmail
    }
}

// MARK: AuthValidationServiceProtocol
extension ValidationService: AuthValidationServiceProtocol {
        
    func validateAuthValidationEmail(_ email: String) throws(AuthorizationValidationError) {
        switch validateEmail(email) {
        case .emptyEmail: throw .emptyEmail
        case .invalidFormatEmail: throw .invalidFormatEmail
        case .none:
            break
        }
    }
    
    func validateAuthPassword(_ password: String) throws(AuthorizationValidationError) {
        if password.isEmpty { throw .emptyPassword }
    }
}

// MARK: RegistrValidationServiceProtocol
extension ValidationService: RegistrValidationServiceProtocol {
    
    func validateRegistrationEmail(_ email: String) throws(RegistrationValidationError) {
        switch validateEmail(email) {
        case .emptyEmail: throw .emptyEmail
        case .invalidFormatEmail: throw .invalidFormatEmail
        case .none:
            break
        }
    }
    
    func validateRegistrationPassword(_ password: String) throws(RegistrationValidationError) {
        
        guard !password.isEmpty else { throw .emptyPassword }
        guard password.count >= 6 else { throw .tooShort(minLength: 6) }
        guard password.contains(where: { $0.isUppercase }) else { throw .lacksUppercase }
        guard password.contains(where: { $0.isLowercase }) else { throw .lacksLowercase }
        guard password.contains(where: { $0.isNumber }) else { throw .lacksDigit }
    }
    
    func validateRegistrationConfirmPassword(_ password: String, _ confirmPassword: String) throws(RegistrationValidationError) {
        guard password == confirmPassword else { throw .doesNotMatch }
    }
}
