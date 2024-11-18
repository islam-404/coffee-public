//
//  CollectionCellConfiguratorProtocol.swift
//  DataConverterUtilites
//
//  Created by islam on 12.09.2024.
//

import UIKit

/// Протокол для конфигурирования ячеек коллекции.
protocol CollectionCellConfiguratorProtocol {
    
    /// Конфигурирует ячейку с использованием предоставленных данных.
    /// - Parameter cell: Ячейка, которую необходимо сконфигурировать.
    func configure(cell: UICollectionViewCell)
    
    /// Тип ячейки, используемый для регистрации и переиспользования.
    static var cellType: UICollectionViewCell.Type { get }
}
