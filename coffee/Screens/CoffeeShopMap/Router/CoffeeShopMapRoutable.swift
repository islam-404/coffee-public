//
//  CoffeeShopMapRoutable.swift
//  coffee
//
//  Created islam on 12.11.2024.
//

import Foundation
//import ViperUtilites
//import FittedSheets

protocol CoffeeShopMapRoutable {
    func openCoffeeShopMapScreen(inputModel: CoffeeShopMapInputModel)
}

extension CoffeeShopMapRoutable where Self: BaseRouter {
    
    func openCoffeeShopMapScreen(inputModel: CoffeeShopMapInputModel) {
        
        let vc = CoffeeShopMapAssembly.assembleModule(inputModel: inputModel)
        transitionHandler?.pushModule(with: vc, animated: true, hidesBottomBarWhenPushed: true)
    }
}
