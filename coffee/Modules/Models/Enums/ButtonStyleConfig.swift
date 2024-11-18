//
//  ButtonStyleConfig.swift
//  coffee
//
//  Created by islam on 17.11.2024.
//

import UIKit

enum ButtonStyleConfig {
    case filled
    case textOnly
    
    var configuration: Configuration {
        switch self {
        case .filled: .init(backgroundColor: .tintColorCof, titleColor: .secondaryCof)
        case .textOnly: .init(backgroundColor: .clear, titleColor: .tintColorCof)
        }
    }
    
    struct Configuration {
        let backgroundColor: UIColor
        let titleColor: UIColor

        func apply(to button: UIButton) {
            button.backgroundColor = backgroundColor
            button.setTitleColor(titleColor, for: .normal)
        }
    }
}
