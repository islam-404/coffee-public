//
//  AuthorizationValidationError.swift
//  Services
//
//  Created by islam on 06.11.2024.
//

import Foundation

public enum AuthorizationValidationError: LocalizedError {
    
    case emptyEmail
    case emptyPassword
    case invalidFormatEmail
    case invalidLogin
    case unknownError
    
    public var errorDescription: String? {
        
        switch self {
        case .emptyEmail:
            return "Адрес электронной почты не может быть пустым."
        case .emptyPassword:
            return "Пароль не может быть пустым."
        case .invalidFormatEmail:
            return "Неверный формат адреса электронной почты."
        case .invalidLogin:
            return "Неверный логин или пароль."
        case .unknownError:
            return "Произошла неизвестная ошибка."
        }
    }
}
