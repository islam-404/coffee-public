//
//  CoffeeShopListPresenter.swift
//  coffee
//
//  Created islam on 09.11.2024.
//

import Foundation
import YandexMapsMobile

final class CoffeeShopListPresenter {
    
    // MARK: - Properties
    
    private weak var view: CoffeeShopListViewInput?
    private let interactor: CoffeeShopListInteractorInput
    private let router: CoffeeShopListRouterInput
    private let inputModel: CoffeeShopListInputModel
    private let dataConverter: CoffeeShopListDataConverterInput
    
    private var currentLocation: YMKPoint?
    private var coffeeShops: [CoffeeShopModel] = []
    
    // MARK: - Init
    
    init(view: CoffeeShopListViewInput,
         interactor: CoffeeShopListInteractorInput,
         router: CoffeeShopListRouterInput,
         inputModel: CoffeeShopListInputModel,
         dataConverter: CoffeeShopListDataConverterInput) 
    {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.inputModel = inputModel
        self.dataConverter = dataConverter
    }
    
    private func calculateDistances() {
        guard let currentLocation = currentLocation else { return }
        
        coffeeShops.forEach {
            guard let latitude = Double($0.point.latitude),
                  let longitude = Double($0.point.longitude) else { return }
            
            let shopLocation = YMKPoint(latitude: latitude, longitude: longitude)
            
            let distance = YMKDistance(currentLocation, shopLocation)
            let roundedDistance = (distance * 100).rounded() / 100
            $0.point.distance = roundedDistance
        }
        
        let covertedData = dataConverter.convert(with: coffeeShops, delegate: self)
        view?.updateData(data: covertedData)
    }
}

// MARK: - CoffeeShopListViewOutput
extension CoffeeShopListPresenter: CoffeeShopListViewOutput {
    
    func viewLoaded() {
        view?.setupInitialState()
        interactor.fetchCoffeeShops()
        interactor.fetchUserLocation()
    }
}

// MARK: - CoffeeShopListInteractorOutput
extension CoffeeShopListPresenter: CoffeeShopListInteractorOutput {

    func didFetchCoffeeShops(_ coffeeShops: [CoffeeShopModel]) {
        self.coffeeShops = coffeeShops
        calculateDistances()
        let covertedData = dataConverter.convert(with: coffeeShops, delegate: self)
        view?.updateData(data: covertedData)
    }
    
    func didFetchLocation(latitude: Double, longitude: Double) {
        currentLocation = .init(latitude: latitude, longitude: longitude)
        calculateDistances()
    }
}

// MARK: - CoffeeShopCVCellDelegate
extension CoffeeShopListPresenter: CoffeeShopCVCellDelegate {
    func didTapCoffeeShop(_ id: Int) {
        let inputModel = MenuInputModel(coffeeShopId: id)
        router.openMenuScreen(inputModel: inputModel)
    }
}

// MARK: - ButtonSectionViewDelegate
extension CoffeeShopListPresenter: ButtonSectionViewDelegate {
    
    func buttonViewTapped(key: String?) {    
        let inputModel = CoffeeShopMapInputModel(placemarks: coffeeShops)
        router.openCoffeeShopMapScreen(inputModel: inputModel)
    }
}
