//
//  ConfigurableCVCell.swift
//  DataConverterUtilites
//
//  Created by islam on 12.09.2024.
//

import UIKit

/// Протокол, который определяет конфигурируемую ячейку для UICollectionView.
public protocol ConfigurableCVCell {
    
    /// Модель данных, с которой работает ячейка.
    associatedtype Model
    
    /// Модель данных для настройки ячейки.
    /// - Parameter model: Модель данных для конфигурации ячейки.
    func configure(with model: Model)
    
//    /// Тип модели секции.
//    /// Перечисление, представляющее типы компоновки секций для UICollectionView.
//    associatedtype TypeLayoutSectionModel
    
//    /// Создает и возвращает секцию компоновки для коллекции.
//    /// - Parameter type: Тип модели секции.
//    /// - Returns: NSCollectionLayoutSection, который используется для компоновки ячеек.
//    static func getLayoutSection(type: TypeLayoutSectionModel) -> NSCollectionLayoutSection
}

/// Расширение для `ConfigurableCVCell`, которое добавляет поддержку создания ячеек с помощью фабричного метода.
extension ConfigurableCVCell where Self: UICollectionViewCell {
    
    /// Фабричный метод для создания конфигуратора ячейки.
    /// - Parameter model: Модель данных для конфигурации ячейки.
    /// - Returns: Конфигуратор для создания и настройки ячейки.
    private static func createConfigurator(with model: Model) -> CollectionCellConfigurator<Self, Model> {
        return CollectionCellConfigurator(model: model)
    }
    
    /// Функция для получения конфигуратора и строки для использования в секциях.
    /// - Parameter model: Модель данных для конфигурации ячейки.
    /// - Returns: Объект Row, который включает в себя конфигуратор ячейки.
    public static func createCellConfigurator(id: UUID = UUID(), with model: Model) -> CollectionViewModel.Section.Row {
        let configurator = createConfigurator(with: model)
        return CollectionViewModel.Section.Row(id: id, configurator: configurator)
    }
}
