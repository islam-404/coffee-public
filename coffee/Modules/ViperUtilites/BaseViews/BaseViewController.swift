//
//  BaseViewController.swift
//  ViperUtilites
//
//  Created by islam on 11.09.2024.
//

import UIKit

open class BaseViewController: UIViewController {
    
    lazy private(set) var safeArea = view.safeAreaLayoutGuide
    lazy private(set) var topHeigthSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    lazy private(set) var bottomHeigthSafeArea = (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) + (tabBarController?.tabBar.frame.size.height ?? 0)
    
    
    deinit {
        debugPrint(#function, type(of: self))
    }
}

extension BaseViewController: TransitionHandler {
    
    public func pushModule(with viewController: UIViewController,
                           animated: Bool,
                           hidesBottomBarWhenPushed: Bool) {
        
        viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func addBeforeModule(with viewController: UIViewController,
                                animated: Bool,
                                hidesBottomBarWhenPushed: Bool) {
        
        viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        let viewControllersCount = navigationController?.viewControllers.count ?? 0
        navigationController?.viewControllers.insert(viewController, at: viewControllersCount - 1)
    }
    
    public func presentModule(with viewController: UIViewController,
                              completion: (() -> Void)?) {
        present(viewController, animated: true, completion: completion)
    }
    
    public func dismissModule(animated: Bool,
                              completion: (() -> Void)?) {
        dismiss(animated: animated, completion: completion)
    }
    
    public func popViewController(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    public func popToRootViewController(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    public func popToViewController(viewController: AnyClass, animated: Bool) {
        navigationController?.viewControllers.forEach {
            if $0.isKind(of: viewController) {
                navigationController?.popToViewController($0, animated: true)
            }
        }
    }
    
    public func fetchViewControllers() -> [UIViewController]? {
        return navigationController?.viewControllers
    }
    
    public func fetchTabBar() -> UITabBarController? {
        return tabBarController
    }
    
    public func fetchParentVC() -> UIViewController? {
        return parent
    }
}

