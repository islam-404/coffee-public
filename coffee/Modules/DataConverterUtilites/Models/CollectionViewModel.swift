//
//  CollectionViewModel.swift
//  DataConverterUtilites
//
//  Created by islam on 12.09.2024.
//

import UIKit

/// Модель данных для коллекции, которая включает секции и их конфигурацию.
public struct CollectionViewModel {
    
    /// Массив секций в коллекции.
    public var sections: [Section]
    
    public init(sections: [Section]) {
        self.sections = sections
    }

//    var absolutePositionViews: [AbsolutePositionView] 
    
    /// Модель секции коллекции.
    public struct Section {
        
        /// Айди для Diffable Data Source
        let id: UUID
        
        /// Массив строк в секции.
        public var rows: [Row]
        
        /// Макет секции.
        let layout: NSCollectionLayoutSection
        
        /// Конфигурация вида заголовка секции, если есть.
        var viewForHeader: View?
        
        /// Конфигурация вида футера секции, если есть.
        var viewForFooter: View?
        
        /// Конфигурация вида фона секции, если есть.
        var viewForBackground: View?
        
        public init(id: UUID = .init(),
                    rows: [Row],
                    layout: NSCollectionLayoutSection,
                    viewForHeader: View? = nil,
                    viewForFooter: View? = nil,
                    viewForBackground: View? = nil) {
            self.id = id
            self.rows = rows
            self.layout = layout
            self.viewForHeader = viewForHeader
            self.viewForFooter = viewForFooter
            self.viewForBackground = viewForBackground
        }
        
        /// Модель для вида в секции (заголовок, футер, фон).
        public struct View {
            
            /// Айди для Diffable Data Source
            public let id: UUID = UUID()
            
            /// Конфигуратор для настройки вида.
            let configurator: CollectionViewConfiguratorProtocol
            
            /// Идентификатор для повторного использования вида, получаемый из конфигуратора.
            var reuseIdentifier: String {
                return String(describing: type(of: configurator).reuseId)
            }
            
            /// Тип вида для повторного использования, получаемый из конфигуратора.
            var viewType: UICollectionReusableView.Type {
                return type(of: configurator).reuseId
            }
        }
        
        /// Модель ячейки в секции.
        public struct Row {
            
            /// Айди для Diffable Data Source
            let id: UUID
            
            /// Конфигуратор для настройки ячейки.
            let configurator: any CollectionCellConfiguratorProtocol
            
            /// Тип ячейки для повторного использования, получаемый из конфигуратора.
            var cellType: UICollectionViewCell.Type {
                return type(of: configurator).cellType
            }
            
            init(id: UUID = .init(),
                 configurator: any CollectionCellConfiguratorProtocol) {
                self.id = id
                self.configurator = configurator
            }
        }
    }
}

extension CollectionViewModel.Section {
    
    /// Пустой макет для секции. Используется в случае, если секция не содержит элементов.
    private static var emptyLayout: NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: .estimated(0.1),
            heightDimension: .estimated(0.1)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
    
    /// Пустая секция, используемая для создания базовой структуры секции.
    public static var emptySection: CollectionViewModel.Section {
        return .init(rows: [], layout: emptyLayout)
    }
}
