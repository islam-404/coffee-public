//
//  CoffeeShopMapPresenter.swift
//  coffee
//
//  Created islam on 12.11.2024.
//

import Foundation

final class CoffeeShopMapPresenter {
    
    // MARK: - Properties
    
    private weak var view: CoffeeShopMapViewInput?
    private let interactor: CoffeeShopMapInteractorInput
    private let router: CoffeeShopMapRouterInput
    private let inputModel: CoffeeShopMapInputModel
    private let dataConverter: CoffeeShopMapDataConverterInput
    
    // MARK: - Init
    
    init(view: CoffeeShopMapViewInput,
         interactor: CoffeeShopMapInteractorInput,
         router: CoffeeShopMapRouterInput,
         inputModel: CoffeeShopMapInputModel,
         dataConverter: CoffeeShopMapDataConverterInput) 
    {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.inputModel = inputModel
        self.dataConverter = dataConverter
    }
    
}

// MARK: - CoffeeShopMapViewOutput
extension CoffeeShopMapPresenter: CoffeeShopMapViewOutput {
    
    func viewLoaded() {
        view?.setupInitialState()
        view?.setPoints(placemarks: inputModel.placemarks)
    }
}

// MARK: - CoffeeShopMapInteractorOutput
extension CoffeeShopMapPresenter: CoffeeShopMapInteractorOutput {
    
}
