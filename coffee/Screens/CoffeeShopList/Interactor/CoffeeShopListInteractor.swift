//
//  CoffeeShopListInteractor.swift
//  coffee
//
//  Created islam on 09.11.2024.
//

import YandexMapsMobile

final class CoffeeShopListInteractor: NSObject {
        
    // MARK: - Properties
    
    weak var output: CoffeeShopListInteractorOutput?
    
    private let service: CoffeeShopListServiceProtocol
    private let locationManager = YMKMapKit.sharedInstance().createLocationManager()
    
    // MARK: - Init
    
    init(service: CoffeeShopListServiceProtocol) {
        self.service = service
    }
}


// MARK: - CoffeeShopListInteractorInput
extension CoffeeShopListInteractor: CoffeeShopListInteractorInput {
    
    func fetchCoffeeShops() {
        
        service.getList { result in
            switch result {
            case .success(let shops):
                self.output?.didFetchCoffeeShops(shops)
            case .failure:
                break
//                self.output?.didFailToFetchCoffeeShops()
            }
        }
    }
}

// MARK: - YMKUserLocationObjectListener, YMKLocationDelegate
extension CoffeeShopListInteractor: YMKUserLocationObjectListener, YMKLocationDelegate {
    
    func onObjectAdded(with view: YMKUserLocationView) {}
    
    func onObjectRemoved(with view: YMKUserLocationView) {}
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {}
    
    func onLocationUpdated(with location: YMKLocation) {
        let latitude = location.position.latitude
        let longitude = location.position.longitude
        output?.didFetchLocation(latitude: latitude, longitude: longitude)
        locationManager.unsubscribe(withLocationListener: self)
    }
    
    func onLocationStatusUpdated(with status: YMKLocationStatus) {}
    
    
    func fetchUserLocation() {
        let desiredAccuracy: Double = 50.0  // Точность в метрах
        let minTime: Int64 = 1000           // Минимальное время между обновлениями в миллисекундах
        let minDistance: Double = 10.0      // Минимальное расстояние между обновлениями в метрах
        let allowUseInBackground = false    // Использование в фоне
        let filteringMode: YMKLocationFilteringMode = .on
        let purpose: YMKLocationPurpose = .general

        // Подписка на обновления
        locationManager.subscribeForLocationUpdates(
            withDesiredAccuracy: desiredAccuracy,
            minTime: minTime,
            minDistance: minDistance,
            allowUseInBackground: allowUseInBackground,
            filteringMode: filteringMode,
            purpose: purpose,
            locationListener: self
        )
    }
}
