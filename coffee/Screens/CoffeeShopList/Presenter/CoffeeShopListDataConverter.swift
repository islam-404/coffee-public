//
//  CoffeeShopListDataConverter.swift
//  coffee
//
//  Created islam on 09.11.2024.
//

import Foundation
//import DataConverterUtilites

protocol CoffeeShopListDataConverterInput {
    func convert(with model: [CoffeeShopModel], delegate: AnyObject) -> CollectionViewModel
}

final class CoffeeShopListDataConverter: CoffeeShopListDataConverterInput {
    
    private typealias Section = CollectionViewModel.Section
    private typealias Row = CollectionViewModel.Section.Row
    
    func convert(with model: [CoffeeShopModel], delegate: AnyObject) -> CollectionViewModel {
        
        var collectionVM = CollectionViewModel(sections: [])
        
        guard let presenter = delegate as? CoffeeShopListPresenter else { return collectionVM }
        

        let layout = ConstantLayoutSection.coffeeShopAndOrderSection
        
        var section = Section(rows: [], layout: layout)
        
        model.forEach { coffeeShop in
            let model = CoffeeShopCVCell.Model(coffeeShop: coffeeShop, delegate: presenter)
            section.rows.append(CoffeeShopCVCell.createCellConfigurator(with: model))
        }
        
        collectionVM.sections.append(section)
        
        
        return collectionVM
    }
}
