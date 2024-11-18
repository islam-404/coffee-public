//
//  AppRouterInput.swift
//  coffee
//
//  Created by islam on 03.11.2024.
//

import UIKit

protocol AppRouterInput {
    func openAuthorizationScreen(inputModel: AuthorizationInputModel, isSavePreviousScreen: Bool)
    func openRegistrationScreen(inputModel: RegistrationInputModel)
    func openCoffeeShopListScreen()
    func openPreviousScreen()
}
