//
//  CollectionAssembly.swift
//  DataConverterUtilites
//
//  Created by islam on 13.09.2024.
//

import Foundation

public final class CollectionAssembly {
    
    public static func assemble() -> BaseCollectionView {
        
        
        let cv = BaseCollectionView()
        let cvRegistrar = CollectionViewRegistrar()
        let delegate = BaseCVDelegate(getViewModel: cv.sendingData)
        let dataSource = DiffableDataSourceCV(collectionView: cv, getViewModel: cv.sendingData)
        
        cvRegistrar.setCollectionView(cv)
        cv.setComponents(registrar: cvRegistrar, dataSource: dataSource, delegate: delegate)
        
        return cv
    }
}
