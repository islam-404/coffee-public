//
//  RegistrationAssembly.swift
//  coffee
//
//  Created islam on 17.11.2024.
//

import UIKit

final class RegistrationAssembly {
    
    static func assembleModule(inputModel: RegistrationInputModel) -> UIViewController {
        
        let authService = AuthService(networkManager: NetworkManagerImp())
        let validator = ValidationService()
        
        let collectionViewManager = CollectionAssembly.assemble()
        let dataConverter = RegistrationDataConverter()
        
        let view = RegistrationViewController()
        let router = RegistrationRouter(view: view)
        let interactor = RegistrationInteractor(service: authService, validator: validator)
        let presenter = RegistrationPresenter(view: view,
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
