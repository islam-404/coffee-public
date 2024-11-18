//
//  MenuRoutable.swift
//  coffee
//
//  Created islam on 13.11.2024.
//

import Foundation
//import ViperUtilites
//import FittedSheets

protocol MenuRoutable {
    func openMenuScreen(inputModel: MenuInputModel)
}

extension MenuRoutable where Self: BaseRouter {
    func openMenuScreen(inputModel: MenuInputModel) {
        
        let vc = MenuAssembly.assembleModule(inputModel: inputModel)
        transitionHandler?.pushModule(with: vc, animated: true, hidesBottomBarWhenPushed: false)
    }
}
