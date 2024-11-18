//
//  CollectionViewRegistrar.swift
//  DataConverterUtilites
//
//  Created by islam on 12.09.2024.
//

import UIKit

protocol CollectionViewRegistrarProtocol: AnyObject {
    func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String)
    func register(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String)
    /// Как сделать доступ к методам коллекции для регистрации DecorationView ? если там доступ через flow layout
}

final class CollectionViewRegistrar {
    
    private weak var collectionView: UICollectionView?
    private var registrationCells: Set<String> = []
    private var registrationHeaderViews: Set<String> = []
    private var registrationFooterViews: Set<String> = []
    private var registrationBackgrViews: Set<String> = []
    
    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func register(in sections: [CollectionViewModel.Section]) {
        sections.forEach { section in
            
            registerCells(for: section)
            registerSupplementaryViews(for: section)
        }
    }
    
    private func registerCells(for section: CollectionViewModel.Section) {
        
        section.rows.forEach { row in
            let cellReuseId = String(describing: row.cellType)
            if !registrationCells.contains(cellReuseId) {
                collectionView?.register(row.cellType, forCellWithReuseIdentifier: cellReuseId)
                registrationCells.insert(cellReuseId)
            }
        }
    }
    
    private func registerSupplementaryViews(for section: CollectionViewModel.Section) {
        
        // Регистрация хедеров и футеров
        if let header = section.viewForHeader,
           !registrationHeaderViews.contains(header.reuseIdentifier) {
            collectionView?.register(header.viewType, forSupplementaryViewOfKind: ElementKindCVType.header, withReuseIdentifier: header.reuseIdentifier)
            registrationHeaderViews.insert(header.reuseIdentifier)
        }

        if let footer = section.viewForFooter,
           !registrationFooterViews.contains(footer.reuseIdentifier) {
            collectionView?.register(footer.viewType, forSupplementaryViewOfKind: ElementKindCVType.footer, withReuseIdentifier: footer.reuseIdentifier)
            registrationFooterViews.insert(footer.reuseIdentifier)
        }

        if let background = section.viewForBackground,
           !registrationBackgrViews.contains(background.reuseIdentifier) {
            collectionView?.collectionViewLayout.register(background.viewType, forDecorationViewOfKind: ElementKindCVType.background)
            registrationBackgrViews.insert(background.reuseIdentifier)
        }
    }
    
    deinit {
        debugPrint(#function, type(of: self))
    }
}
