//
//  SceneDelegate.swift
//  coffee
//
//  Created by islam on 03.11.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var appController: AppControllerProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .light
        window.tintColor = .tintColorCof
        
        self.window = window
        appController = AppAssembly.assemble(window: window)
        appController?.start()
    }
}

