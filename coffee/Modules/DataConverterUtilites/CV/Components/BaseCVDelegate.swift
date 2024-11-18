//
//  BaseCVDelegate.swift
//  DataConverterUtilites
//
//  Created by islam on 14.09.2024.
//

import UIKit

final class BaseCVDelegate: NSObject, UICollectionViewDelegate {
    
    private let getViewModel: (() -> [CollectionViewModel.Section])
    
    init(getViewModel: @escaping () -> [CollectionViewModel.Section]) {
        self.getViewModel = getViewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == ElementKindCVType.background,
           let sectionBackView = getViewModel()[indexPath.section].viewForBackground {
            sectionBackView.configurator.configure(view: view)
        }
    }
    
    deinit {
        debugPrint(#function, type(of: self))
    }
}
