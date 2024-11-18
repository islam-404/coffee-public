//
//  CollectionViewConfigurator.swift
//  delivery food
//
//  Created by islam on 04.12.2023.
//

import UIKit

/// Конфигуратор для Header, Footer, Background, Reusable View коллекции.
struct CollectionViewConfigurator<ViewType: ConfigurableCVView, Model>: CollectionViewConfiguratorProtocol
where ViewType: UICollectionReusableView, ViewType.Model == Model {
    
    // MARK: - Properties
    
    /// Тип view, используемый для регистрации и переиспользования.
    static var reuseId: UICollectionReusableView.Type { return ViewType.self }
    
    /// Модель данных, используемая для конфигурации view.
    private let model: Model
    
    // MARK: - Init
    
    /// Инициализирует конфигуратор с моделью данных.
    /// - Parameter item: Модель данных, используемая для конфигурации view.
    init(model: Model) {
        self.model = model
    }
    
    // MARK: - Public methods
    
    /// Конфигурирует view с использованием предоставленной модели данных.
    /// - Parameter cell: View, которую необходимо сконфигурировать.
    func configure(view: UICollectionReusableView) {
        (view as? ViewType)?.configure(with: model)
    }
}
