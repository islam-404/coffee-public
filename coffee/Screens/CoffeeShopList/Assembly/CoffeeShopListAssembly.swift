//
//  CoffeeShopListAssembly.swift
//  coffee
//
//  Created islam on 09.11.2024.
//

import UIKit
//import DataConverterUtilites

final class CoffeeShopListAssembly {
    
    static func assembleModule(inputModel: CoffeeShopListInputModel) -> UIViewController {
        
        let networkService = NetworkManagerImp()
        let collectionViewManager = CollectionAssembly.assemble()
        let dataConverter = CoffeeShopListDataConverter()
        
        let view = CoffeeShopListViewController()
        let router = CoffeeShopListRouter(view: view)
        let interactor = CoffeeShopListInteractor(service: CoffeeShopListService(networkManager: networkService))
        let presenter = CoffeeShopListPresenter(view: view,
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
