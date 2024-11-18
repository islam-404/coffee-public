//
//  CollectionCellConfigurator.swift
//  DataConverterUtilites
//
//  Created by islam on 12.09.2024.
//

import UIKit

/// Конфигуратор для ячеек коллекции.
struct CollectionCellConfigurator<CellType: ConfigurableCVCell, Model>: CollectionCellConfiguratorProtocol
where CellType.Model == Model, CellType: UICollectionViewCell {
    
    // MARK: - Properties
    
    /// Тип ячейки, используемый для регистрации и переиспользования.
    static var cellType: UICollectionViewCell.Type { return CellType.self }
    
    /// Модель данных, используемая для конфигурации ячейки.
    private let model: Model
    
    // MARK: - Init
    
    /// Инициализирует конфигуратор с моделью данных.
    /// - Parameter item: Модель данных, используемая для конфигурации ячейки.
    init(model: Model) {
        self.model = model
    }
    
    // MARK: - Public methods
    
    /// Конфигурирует ячейку с использованием предоставленной модели данных.
    /// - Parameter cell: Ячейка, которую необходимо сконфигурировать.
    func configure(cell: UICollectionViewCell) {
        (cell as? CellType)?.configure(with: model)
    }
}
