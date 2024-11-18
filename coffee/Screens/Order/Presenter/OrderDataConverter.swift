//
//  OrderDataConverter.swift
//  coffee
//
//  Created islam on 15.11.2024.
//

import Foundation
//import DataConverterUtilites

protocol OrderDataConverterInput {
    func convert(with model: [ProductCDModel], delegate: AnyObject) -> CollectionViewModel
}

final class OrderDataConverter: OrderDataConverterInput {
    
    private typealias Section = CollectionViewModel.Section
    private typealias Row = CollectionViewModel.Section.Row
    
    private let sectionID = UUID()
    
    func convert(with model: [ProductCDModel], delegate: AnyObject) -> CollectionViewModel {
        
        var collectionVM = CollectionViewModel(sections: [])
        
        guard let presenter = delegate as? OrderPresenter else { return collectionVM }
        
        let layout = ConstantLayoutSection.coffeeShopAndOrderSection
        
        var section = Section(id: sectionID, rows: [], layout: layout)
        
        model.forEach { product in
            let model = ProductInCartCVCell.Model(product: product, delegate: presenter)
            section.rows.append(ProductInCartCVCell.createCellConfigurator(id: product.uuid ?? UUID(), with: model))
        }
        
        collectionVM.sections.append(section)
        
        return collectionVM
    }
}
