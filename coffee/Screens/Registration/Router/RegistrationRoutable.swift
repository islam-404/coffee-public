//
//  RegistrationRoutable.swift
//  coffee
//
//  Created islam on 17.11.2024.
//

import Foundation

protocol RegistrationRoutable {
    func openRegistrationScreen(inputModel: RegistrationInputModel)
}

extension RegistrationRoutable where Self: BaseRouter {
    func openRegistrationScreen(inputModel: RegistrationInputModel) {
        
    }
}
