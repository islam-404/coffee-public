//
//  KeyboardSetting.swift
//  coffee
//
//  Created by islam on 16.11.2024.
//

import UIKit

enum KeyboardSetting {
    
    case email
    case password
    case defaultSetting

    var configuration: Configuration {
        switch self {
        case .email:
            return Configuration(
                keyboardType: .emailAddress,
                textContentType: .username,
                autocorrectionType: .no,
                autocapitalizationType: .none,
                isSecureTextEntry: false
            )
        case .password:
            return Configuration(
                keyboardType: .default,
                textContentType: .password,
                autocorrectionType: .default,
                autocapitalizationType: .sentences,
                isSecureTextEntry: true
            )
        case .defaultSetting:
            return Configuration(
                keyboardType: .default,
                textContentType: nil,
                autocorrectionType: .default,
                autocapitalizationType: .sentences,
                isSecureTextEntry: false
            )
        }
    }

    struct Configuration {
        let keyboardType: UIKeyboardType
        let textContentType: UITextContentType?
        let autocorrectionType: UITextAutocorrectionType
        let autocapitalizationType: UITextAutocapitalizationType
        let isSecureTextEntry: Bool

        func apply(to textField: UITextField) {
            textField.keyboardType = keyboardType
            textField.textContentType = textContentType
            textField.autocorrectionType = autocorrectionType
            textField.autocapitalizationType = autocapitalizationType
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
}

