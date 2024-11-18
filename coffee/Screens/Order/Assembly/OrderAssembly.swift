//
//  OrderAssembly.swift
//  coffee
//
//  Created islam on 15.11.2024.
//

import UIKit
//import DataConverterUtilites

final class OrderAssembly {
    
    static func assembleModule(inputModel: OrderInputModel) -> UIViewController {
        
//        let networkService = OrderNetworkService()
        let collectionViewManager = CollectionAssembly.assemble()
        let dataConverter = OrderDataConverter()
        
        let view = OrderViewController()
        let router = OrderRouter(view: view)
        let interactor = OrderInteractor()
        let presenter = OrderPresenter(view: view,
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
