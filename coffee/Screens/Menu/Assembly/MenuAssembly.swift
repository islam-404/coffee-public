//
//  MenuAssembly.swift
//  coffee
//
//  Created islam on 13.11.2024.
//

import UIKit
//import DataConverterUtilites

final class MenuAssembly {
    
    static func assembleModule(inputModel: MenuInputModel) -> UIViewController {
        
        let networkService = NetworkManagerImp()
        let productService = ProductsService(networkManager: networkService)
        let collectionViewManager = CollectionAssembly.assemble()
        let dataConverter = MenuDataConverter()
        
        let view = MenuViewController()
        let router = MenuRouter(view: view)
        let interactor = MenuInteractor(service: productService,
                                        coffeeShopId: inputModel.coffeeShopId)
        
        let presenter = MenuPresenter(view: view,
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
