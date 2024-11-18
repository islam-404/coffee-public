//
//  MenuDataConverter.swift
//  coffee
//
//  Created islam on 13.11.2024.
//

import Foundation
//import DataConverterUtilites

protocol MenuDataConverterInput {
    func convert(with model: [ProductModel], delegate: AnyObject) -> CollectionViewModel
}

final class MenuDataConverter: MenuDataConverterInput {
    
    private typealias Section = CollectionViewModel.Section
    private typealias Row = CollectionViewModel.Section.Row
    
    func convert(with model: [ProductModel], delegate: AnyObject) -> CollectionViewModel {
        
        var collectionVM = CollectionViewModel(sections: [])
        
        guard let presenter = delegate as? MenuPresenter else { return collectionVM }
        
        let layoutSection = SectionConfig()
            .addItem(
                w: .fractionalWidth(0.5),
                h: .fractionalHeight(1),
                insets: .init(top: 0, leading: 16, bottom: 0, trailing: 6)
            )
            .addItem(
                w: .fractionalWidth(0.5),
                h: .fractionalHeight(1),
                insets: .init(top: 0, leading: 6, bottom: 0, trailing: 16)
            )
            .setGroup(
                w: .fractionalWidth(1),
                h: .estimated(205),
                direction: .horizontal
            )
            .setSection(
                insets: .init(top: 16, leading: 0, bottom: 16, trailing: 0),
                spacing: 13
            )
            .build()
        
        var section = Section(rows: [], layout: layoutSection)
        
        model.enumerated().forEach { index, product in
            let model = ProductCVCell.Model(index: index, product: product, delegate: presenter)
            let row = ProductCVCell.createCellConfigurator(with: model)
            section.rows.append(row)
        }
        
        collectionVM.sections.append(section)
        return collectionVM
    }
}
