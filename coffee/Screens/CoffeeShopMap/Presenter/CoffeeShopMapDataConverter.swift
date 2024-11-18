//
//  CoffeeShopMapDataConverter.swift
//  coffee
//
//  Created islam on 12.11.2024.
//

import Foundation
//import DataConverterUtilites

protocol CoffeeShopMapDataConverterInput {
    func convert(with model: String, delegate: AnyObject) -> CollectionViewModel
}

final class CoffeeShopMapDataConverter: CoffeeShopMapDataConverterInput {
    
    private typealias Section = CollectionViewModel.Section
    private typealias Row = CollectionViewModel.Section.Row
    
    func convert(with model: String, delegate: AnyObject) -> CollectionViewModel {
        
        var collectionVM = CollectionViewModel(sections: [])
        
        
        return collectionVM
    }
}
