//
//  BaseRouter.swift
//  ViperUtilites
//
//  Created by islam on 11.09.2024.
//

import Foundation

open class BaseRouter {
    
    public weak var transitionHandler: TransitionHandler?
    
    public init(view: TransitionHandler) {
        transitionHandler = view
    }
}
