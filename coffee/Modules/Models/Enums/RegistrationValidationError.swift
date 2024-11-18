//
//  PasswordValidationError.swift
//  Services
//
//  Created by islam on 06.11.2024.
//

import Foundation

public enum RegistrationValidationError: LocalizedError {
    
    case emptyEmail
    case emptyPassword
    case invalidFormatEmail
    case tooShort(minLength: Int)
    case lacksUppercase
    case lacksLowercase
    case lacksDigit
    case doesNotMatch
    
    public var errorDescription: String? {
        
        switch self {
            
        case .emptyEmail:
            return "Адрес электронной почты не может быть пустым."
            
        case .emptyPassword:
            return "Пароль не может быть пустым."
            
        case .invalidFormatEmail:
            return "Неверный формат адреса электронной почты."
            
        case .tooShort(let minLength):
            return "Пароль должен содержать минимум \(minLength) символов."
            
        case .lacksUppercase:
            return "Пароль должен содержать хотя бы одну заглавную букву."
            
        case .lacksLowercase:
            return "Пароль должен содержать хотя бы одну строчную букву."
            
        case .lacksDigit:
            return "Пароль должен содержать хотя бы одну цифру."
            
        case .doesNotMatch:
            return "Пароли не совпадают."
        }
    }
}
