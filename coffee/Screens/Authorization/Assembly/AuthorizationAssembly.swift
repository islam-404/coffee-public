//
//  AuthorizationAssembly.swift
//  coffee
//
//  Created islam on 03.11.2024.
//

import UIKit
//import DataConverterUtilites
//import Services
//import NetworkLayer

final class AuthorizationAssembly {
    
    static func assembleModule(inputModel: AuthorizationInputModel) -> UIViewController {
        
        let networkService = AuthService(networkManager: NetworkManagerImp())
        let validationService = ValidationService()
        let collectionViewManager = CollectionAssembly.assemble()
        let dataConverter = AuthorizationDataConverter()
        
        let view = AuthorizationViewController()
        let router = AuthorizationRouter(view: view)
        
        let interactor = AuthorizationInteractor(service: networkService,
                                                 validator: validationService)
        
        let presenter = AuthorizationPresenter(view: view,
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
