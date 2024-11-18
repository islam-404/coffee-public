//
//  CoffeeShopMapViewController.swift
//  coffee
//
//  Created islam on 12.11.2024.
//

import UIKit
import YandexMapsMobile

final class CoffeeShopMapViewController: BaseViewController {
	
    // MARK: - Properties
    
	var output: CoffeeShopMapViewOutput?
    var collectionView: BaseCollectionView?
    private var mapView = YMKMapView()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }
}

// MARK: - CoffeeShopMapViewInput
extension CoffeeShopMapViewController: CoffeeShopMapViewInput {
    
    func setupInitialState() {
        
        title = "Карта"
        view.backgroundColor = .white
        view.addSubview(mapView)
        mapView.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        })
    }
    
    func setPoints(placemarks: [CoffeeShopModel]) {
        
        guard let firstPoint = placemarks.first?.point,
              let latitude = Double(firstPoint.latitude),
              let longitude = Double(firstPoint.longitude)
        else { return }
        
        let initialLocation = YMKPoint(latitude: latitude, longitude: longitude)
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: initialLocation, zoom: 10, azimuth: 0, tilt: 0))
        
        let mapObjects = mapView.mapWindow.map.mapObjects
        
        for point in placemarks {
            guard let latitude = Double(point.point.latitude),
                  let longitude = Double(point.point.longitude)
            else { continue }
            
            let placemark = mapObjects.addPlacemark()
            placemark.geometry = YMKPoint(latitude: latitude, longitude: longitude)
            placemark.setTextWithText(point.name)
            placemark.setTextStyleWith(.init(size: 14, color: .textCof, outlineWidth: 1, outlineColor: .textCof, placement: .bottom, offset: 0, offsetFromIcon: true, textOptional: false))
            placemark.setIconWith(UIImage(resource: .icMapPlacemark))
        }
    }
    
    func updateData(data: CollectionViewModel) {
        collectionView?.updateData(data: data)
    }
}
