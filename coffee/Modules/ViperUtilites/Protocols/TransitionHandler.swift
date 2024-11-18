//
//  TransitionHandler.swift
//  ViperUtilites
//
//  Created by islam on 12.09.2024.
//

import UIKit

public protocol TransitionHandler: AnyObject {
    func pushModule(with viewController: UIViewController, animated: Bool, hidesBottomBarWhenPushed: Bool)
    func addBeforeModule(with viewController: UIViewController, animated: Bool, hidesBottomBarWhenPushed: Bool)
    func presentModule(with viewController: UIViewController, completion: (() -> Void)?)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func popViewController(animated: Bool)
    func popToRootViewController(animated: Bool)
    func popToViewController(viewController: AnyClass, animated: Bool)
    func fetchViewControllers() -> [UIViewController]?
    func fetchTabBar() -> UITabBarController?
    func fetchParentVC() -> UIViewController?
}
