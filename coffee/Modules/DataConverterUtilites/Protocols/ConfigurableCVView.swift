//
//  ConfigurableCVView.swift
//  delivery food
//
//  Created by islam on 04.12.2023.
//

import UIKit

//MARK: - Collection View Cell Configurable

/// Протокол, который определяет конфигурируемый вид для `UICollectionReusableView`.
public protocol ConfigurableCVView {
    
    /// Модель данных, с которой работает конфигурируемый вид.
    associatedtype Model
    
    /// Тип представления, используемый для настройки в коллекции.
    typealias View = CollectionViewModel.Section.View
    
    /// Метод для конфигурации вида с моделью данных.
    /// - Parameter model: Модель данных, которая используется для настройки вида.
    func configure(with model: Model)
}

/// Расширение для `ConfigurableCVView`, добавляющее поддержку создания представлений для `UICollectionReusableView`.
extension ConfigurableCVView where Self: UICollectionReusableView {
    
    /// Конфигуратор для настройки представления.
    typealias Configurator = CollectionViewConfigurator<Self, Model>
    
    /// Создает объект представления для коллекции с помощью указанной модели данных.
    /// - Parameter model: Модель данных, которая будет использоваться для настройки представления.
    /// - Returns: Объект `CollectionViewModel.Section.View`, настроенный с помощью конфигуратора.
    public static func convertCVView(with model: Model) -> View {
        return View(configurator: Configurator(model: model))
    }
}
