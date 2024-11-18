//
//  DiffableDataSource.swift
//  DataConverterUtilites
//
//  Created by islam on 14.09.2024.
//

import UIKit

final class DiffableDataSourceCV: UICollectionViewDiffableDataSource<UUID, UUID> {
    
    private let getViewModel: (() -> [CollectionViewModel.Section])
    private var snapshot = NSDiffableDataSourceSnapshot<UUID, UUID>()
    
    init(collectionView: UICollectionView, getViewModel: @escaping () -> [CollectionViewModel.Section]) {
        
        self.getViewModel = getViewModel
        
        super.init(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell in
            
            let section = getViewModel()[indexPath.section]
            let row = section.rows[indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: row.cellType), for: indexPath)
            row.configurator.configure(cell: cell)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let section = getViewModel()[indexPath.section]
        
        if let view =
                    (kind == ElementKindCVType.header) ? section.viewForHeader :
                    (kind == ElementKindCVType.footer) ? section.viewForFooter :
            nil {
            
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: view.viewType), for: indexPath)
            view.configurator.configure(view: reusableView)
            return reusableView
            
        } else {
            return .init()
        }
    }
    
    func reloadItems() {
        let sectionIDs = getViewModel().map { $0.id }
        
        var snapshot = self.snapshot
        
        // Проверяем, что все секции существуют в snapshot
        let existingSectionIDs = snapshot.sectionIdentifiers
        
        let sectionsToReload = sectionIDs.filter { existingSectionIDs.contains($0) }
        
        // Если есть секции для перезагрузки, выполняем перезагрузку
        if !sectionsToReload.isEmpty {
            snapshot.reloadSections(sectionsToReload)
        } else {
            print("Нет секций для перезагрузки.")
        }
        
        // Применяем изменения
        DispatchQueue.main.async {
            self.apply(snapshot, animatingDifferences: true) {
                
            }
        }
    }
    
    func applySnapshot() {
        
        snapshot = NSDiffableDataSourceSnapshot<UUID, UUID>()
        
        getViewModel().forEach { section in
            snapshot.appendSections([section.id])
            snapshot.appendItems(section.rows.map { $0.id }, toSection: section.id)
        }
        
        DispatchQueue.main.async {
            self.apply(self.snapshot, animatingDifferences: true)
        }
    }
    
    deinit {
        debugPrint(#function, type(of: self))
    }

}
