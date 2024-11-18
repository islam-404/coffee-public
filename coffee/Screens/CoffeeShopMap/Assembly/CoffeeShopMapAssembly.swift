//
//  CoffeeShopMapAssembly.swift
//  coffee
//
//  Created islam on 12.11.2024.
//

import UIKit
//import DataConverterUtilites

final class CoffeeShopMapAssembly {
    
    static func assembleModule(inputModel: CoffeeShopMapInputModel) -> UIViewController {
        
//        let networkService = CoffeeShopMapNetworkService()
        let collectionViewManager = CollectionAssembly.assemble()
        let dataConverter = CoffeeShopMapDataConverter()
        
        let view = CoffeeShopMapViewController()
        let router = CoffeeShopMapRouter(view: view)
        let interactor = CoffeeShopMapInteractor()
        let presenter = CoffeeShopMapPresenter(view: view,
                                               interactor: interactor,
                                               router: router,
                                               inputModel: inputModel,
                                               dataConverter: dataConverter)
        
        view.output = presenter
        view.collectionView = collectionViewManager
        
        interactor.output = presenter
        
        return view
    }

}
