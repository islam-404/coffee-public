//
//  AppRouter.swift
//  coffee
//
//  Created by islam on 03.11.2024.
//

import UIKit

final class AppRouter {
    
    private let window: UIWindow
    private var previousScreen: UIViewController? ///это не норм, но, что то я б сделал чтобы открыть обратно место где остановился пользаватель
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension AppRouter: AppRouterInput {
    
    func openAuthorizationScreen(inputModel: AuthorizationInputModel, isSavePreviousScreen: Bool) {
        
        if isSavePreviousScreen {
            previousScreen = window.rootViewController
        }
        
        let vc = AuthorizationAssembly.assembleModule(inputModel: inputModel)
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }
    
    func openRegistrationScreen(inputModel: RegistrationInputModel) {

        let vc = RegistrationAssembly.assembleModule(inputModel: inputModel)
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }
    
    func openCoffeeShopListScreen() {
        let vc = CoffeeShopListAssembly.assembleModule(inputModel: CoffeeShopListInputModel())
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }
    
    func openPreviousScreen() {
        if let previousScreen {
            window.rootViewController = previousScreen
            window.makeKeyAndVisible()
        } else {
            openCoffeeShopListScreen()
        }
    }
}
