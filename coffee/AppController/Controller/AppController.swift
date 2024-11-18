//
//  AppController.swift
//  coffee
//
//  Created by islam on 03.11.2024.
//

import UIKit

final class AppController {

    private let router: AppRouterInput
    private let tokenManager: TokenManager
    
    init(router: AppRouterInput, tokenManager: TokenManager) {
        self.router = router
        self.tokenManager = tokenManager
        self.tokenManager.delegate = self
        setAppearance()
    }
    
    private func setAppearance() {
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.textCof
        ]
        let appearanceBackButton = UIBarButtonItemAppearance()
        appearanceBackButton.normal.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        appearance.backButtonAppearance = appearanceBackButton
        UINavigationBar.appearance().tintColor = .textCof
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

// MARK: AppControllerProtocol
extension AppController: AppControllerProtocol {
    
    func start() {

        if !tokenManager.isLifeToken {
            let inputModel = AuthorizationInputModel(delegate: self, authorizationDelegate: .newToken)
            router.openAuthorizationScreen(inputModel: inputModel, isSavePreviousScreen: false)
        } else {
            router.openCoffeeShopListScreen()
        }
    }
}

// MARK: RegistrationScreenDelegate & AuthorizationScreenDelegate
extension AppController: RegistrationScreenDelegate, AuthorizationScreenDelegate {

    func didSuccessAuthorization(data: LoginResponse) {
        tokenManager.token = data.token
        router.openCoffeeShopListScreen()
    }
    
    func didSuccessUpdateToken(data: LoginResponse) {
        tokenManager.token = data.token
        router.openPreviousScreen()
    }

    func openAuthorizationScreen() {
        let inputModel = AuthorizationInputModel(delegate: self, authorizationDelegate: .newToken)
        router.openAuthorizationScreen(inputModel: inputModel, isSavePreviousScreen: false)
    }

    func openRegisterScreen() {
        let inputModel = RegistrationInputModel(delegate: self)
        router.openRegistrationScreen(inputModel: inputModel)
    }
}

// MARK: TokenManagerDelegate
extension AppController: TokenManagerDelegate {
    
    func didExpireToken() {
        let inputModel = AuthorizationInputModel(delegate: self, authorizationDelegate: .updateToken)
        router.openAuthorizationScreen(inputModel: inputModel, isSavePreviousScreen: true)
    }
}
