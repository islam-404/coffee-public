//
//  OrderRoutable.swift
//  coffee
//
//  Created islam on 15.11.2024.
//

import Foundation
//import ViperUtilites
//import FittedSheets

protocol OrderRoutable {
    func openOrderScreen(inputModel: OrderInputModel)
}

extension OrderRoutable where Self: BaseRouter {
    func openOrderScreen(inputModel: OrderInputModel) {
        
        let vc = OrderAssembly.assembleModule(inputModel: inputModel)
        transitionHandler?.pushModule(with: vc, animated: true, hidesBottomBarWhenPushed: false)
    }
}
