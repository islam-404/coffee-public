//
//  AppAssembly.swift
//  coffee
//
//  Created by islam on 03.11.2024.
//

import UIKit

final class AppAssembly {
    
    private init() {}
    
    static func assemble(window: UIWindow) -> AppController {
        
        let router = AppRouter(window: window)
        let tokenManager = TokenManager.shared
        return AppController(router: router, tokenManager: tokenManager)
    }
}
