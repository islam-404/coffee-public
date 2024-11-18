//
//  SectionConfiguration.swift
//  DataConverterUtilites
//
//  Created by islam on 04.11.2024.
//

import UIKit

/// Конфигурация для создания настраиваемых секций `NSCollectionLayoutSection` с гибкой поддержкой различных параметров
///
/// Пример использования
/// ```
///let layoutSection = SectionConfig()
/// .addItem(w: .fractionalWidth(1), h: .fractionalHeight(1),
///             insets: .init(top: 0, leading: 8, bottom: 0, trailing: 8))
/// .addItem(w: .fractionalWidth(1), h: .fractionalHeight(0.5))
/// .setGroup(w: .fractionalWidth(1), h: .estimated(400))
/// .setGroupInsets(insets: .init(top: 0, leading: 16, bottom: 0, trailing: 16))
/// .setGroupSpacing(spacing: 12)
/// .setSection(insets: .init(top: 16, leading: 16, bottom: 16, trailing: 16), spacing: 20, behavior: .continuous)
/// .build()
///```
///
public struct SectionConfig {
    
    public enum GroupLayoutDirection {
        case vertical
        case horizontal
    }

    // MARK: - Item Configuration (Элемент)

//    private var itemWidth: NSCollectionLayoutDimension = .fractionalWidth(1)
//    private var itemHeight: NSCollectionLayoutDimension = .fractionalHeight(1)
//    private var itemInsets: NSDirectionalEdgeInsets = .zero

    // MARK: - Group Configuration (Группа)
    
    private var groupWidth: NSCollectionLayoutDimension = .fractionalWidth(1)
    private var groupHeight: NSCollectionLayoutDimension = .estimated(66)
    private var groupDirection: GroupLayoutDirection = .vertical
    private var groupInsets: NSDirectionalEdgeInsets = .zero
    private var interItemSpacing: CGFloat = 0
    private var items: [NSCollectionLayoutItem] = []

    // MARK: - Section Configuration (Секция)

    private var contentInsetsSection: NSDirectionalEdgeInsets = .init(top: 16, leading: 0, bottom: 0, trailing: 0)
    private var interGroupSpacing: CGFloat = 12
    private var scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous
    private var decorationItems: [NSCollectionLayoutDecorationItem] = []
    private var boundarySupplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = []
    
    public init() {}
    
    // MARK: - Methods for Item Configuration
    
    /// Добавляет элемент с заданными параметрами.
    /// - Parameters:
    ///   - w: Ширина элемента.
    ///   - h: Высота элемента.
    ///   - insets: Внутренние отступы для элемента.
    /// - Returns: Новый экземпляр `SectionConfig` с добавленным элементом.
    public func addItem(w: NSCollectionLayoutDimension = .fractionalWidth(1),
                 h: NSCollectionLayoutDimension = .fractionalHeight(1),
                 insets: NSDirectionalEdgeInsets = .zero) -> SectionConfig {
        var config = self
        let size = NSCollectionLayoutSize(widthDimension: w, heightDimension: h)
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = insets
        config.items.append(item)
        return config
    }
    
    // MARK: - Methods for Group Configuration
    
    /// Устанавливает размеры группы и её направление.
    /// - Parameters:
    ///   - w: Ширина группы.
    ///   - h: Высота группы.
    ///   - direction: Направление группы (`horizontal` или `vertical`). По умолчанию `vertical`
    /// - Returns: Новый экземпляр `SectionConfig` с обновлённой конфигурацией группы.
    public func setGroup(w: NSCollectionLayoutDimension = .fractionalWidth(1),
                         h: NSCollectionLayoutDimension = .fractionalHeight(1), direction: GroupLayoutDirection = .vertical) -> SectionConfig {
        var config = self
        config.groupWidth = w
        config.groupHeight = h
        config.groupDirection = direction
        return config
    }
    
    /// Устанавливает размеры группы
    /// - Parameters:
    ///   - w: Ширина группы.
    ///   - h: Высота группы.
    /// - Returns: Новый экземпляр `SectionConfig` с обновлённой конфигурацией группы.
    public func setGroup(w: NSCollectionLayoutDimension,
                         h: NSCollectionLayoutDimension) -> SectionConfig {
        var config = self
        config.groupWidth = w
        config.groupHeight = h
        return config
    }
    
    /// Устанавливает размеры группы и её направление.
    /// - Parameters:
    ///   - direction: Направление группы (`horizontal` или `vertical`). По умолчанию `vertical`
    /// - Returns: Новый экземпляр `SectionConfig` с обновлённой конфигурацией группы.
    public func setGroupDirection(direction: GroupLayoutDirection) -> SectionConfig {
        var config = self
        config.groupDirection = direction
        return config
    }
    
    /// Устанавливает отступы для группы.
    /// - Parameters:
    ///   - insets: Внутренние отступы группы.
    /// - Returns: Новый экземпляр `SectionConfig` с обновлёнными отступами и межэлементным расстоянием.
    public func setGroupInsets(_ insets: NSDirectionalEdgeInsets) -> SectionConfig {
        var config = self
        config.groupInsets = insets
        return config
    }
    
    /// Устанавливает межэлементное расстояние для группы.
    /// - Parameters:
    ///   - spacing: Расстояние между элементами внутри группы.
    /// - Returns: Новый экземпляр `SectionConfig` с обновлёнными отступами и межэлементным расстоянием.
    public func setGroupSpacing(_ spacing: CGFloat) -> SectionConfig {
        var config = self
        config.interItemSpacing = spacing
        return config
    }

    // MARK: - Methods for Section Configuration

    /// Устанавливает конфигурацию секции.
    /// - Parameters:
    ///   - insets: Внутренние отступы секции.
    ///   - spacing: Расстояние между группами внутри секции.
    ///   - behavior: Поведение прокрутки для секции.
    /// - Returns: Новый экземпляр `SectionConfig` с обновлённой конфигурацией секции.
    public func setSection(insets: NSDirectionalEdgeInsets = .zero, spacing: CGFloat = 0, behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none) -> SectionConfig {
        var config = self
        config.contentInsetsSection = insets
        config.interGroupSpacing = spacing
        config.scrollingBehavior = behavior
        return config
    }
    
    /// Устанавливает конфигурацию секции.
    /// - Parameters:
    ///   - insets: Внутренние отступы секции.
    /// - Returns: Новый экземпляр `SectionConfig` с обновлённой конфигурацией секции.
    public func setSectionContentInsets(_ insets: NSDirectionalEdgeInsets) -> SectionConfig {
        var config = self
        config.contentInsetsSection = insets
        return config
    }
    
    /// Устанавливает конфигурацию для верхнего колонтитула (header) секции.
    ///
    /// Этот метод позволяет настроить верхний колонтитул для секции, определяя его ширину,
    /// высоту и внутренние отступы. Настройка колонтитула влияет на отображение информации
    /// в верхней части секции UICollectionView.
    ///
    /// - Parameters:
    ///   - w: Ширина headerView, заданная в виде NSCollectionLayoutDimension.
    ///   - h: Высота headerView, заданная в виде NSCollectionLayoutDimension.
    ///   - insets: Внутренние отступы секции, заданные в виде NSDirectionalEdgeInsets.
    ///
    /// - Returns: Возвращает новый объект SectionConfig с обновленной конфигурацией,
    /// включая указанный верхний колонтитул.
    public func setHeaderView(w: NSCollectionLayoutDimension,
                              h: NSCollectionLayoutDimension,
                              insets: NSDirectionalEdgeInsets) -> SectionConfig {
        let headerSize = NSCollectionLayoutSize(widthDimension: w, heightDimension: h)
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ElementKindCVType.header, alignment: .top)
        headerView.contentInsets = insets
        var config = self
        config.boundarySupplementaryItems = [headerView]
        
        return config
    }

    /// Устанавливает конфигурацию для декоративного элемента секции.
    ///
    /// Этот метод позволяет добавить декоративный элемент к секции, определяя
    /// его внутренние отступы. Декоративный элемент может использоваться для
    /// стилизации фона секции или добавления визуальных эффектов.
    ///
    /// - Parameters:
    ///   - insets: Внутренние отступы секции, заданные в виде NSDirectionalEdgeInsets.
    ///
    /// - Returns: Возвращает новый объект SectionConfig с обновленной конфигурацией,
    /// включая указанный декоративный элемент.
    public func setDecorationItem(insets: NSDirectionalEdgeInsets) -> SectionConfig {
        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: ElementKindCVType.background)
        decorationItem.contentInsets = insets
        
        var config = self
        config.decorationItems.append(decorationItem)
        
        return config
    }

    /// Устанавливает конфигурацию для нижнего колонтитула (footer) секции.
    ///
    /// Этот метод позволяет настроить нижний колонтитул для секции, определяя его ширину,
    /// высоту и внутренние отступы. Настройка колонтитула влияет на отображение информации
    /// в нижней части секции UICollectionView.
    ///
    /// - Parameters:
    ///   - w: Ширина footerView, заданная в виде NSCollectionLayoutDimension.
    ///   - h: Высота footerView, заданная в виде NSCollectionLayoutDimension.
    ///   - insets: Внутренние отступы секции, заданные в виде NSDirectionalEdgeInsets.
    ///
    /// - Returns: Возвращает новый объект SectionConfig с обновленной конфигурацией,
    /// включая указанный нижний колонтитул.
    public func setFooterView(w: NSCollectionLayoutDimension,
                              h: NSCollectionLayoutDimension,
                              insets: NSDirectionalEdgeInsets) -> SectionConfig {
        let headerSize = NSCollectionLayoutSize(widthDimension: w, heightDimension: h)
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ElementKindCVType.footer, alignment: .bottom)
        headerView.contentInsets = insets
        var config = self
        config.boundarySupplementaryItems = [headerView]
        
        return config
    }


    // MARK: - Build Section

    /// Создаёт и возвращает `NSCollectionLayoutSection` с текущими параметрами конфигурации.
    /// - Returns: Настроенная `NSCollectionLayoutSection`.
    public func build() -> NSCollectionLayoutSection {
        // Создаём группу с заданными размерами и элементами
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
        
        let group: NSCollectionLayoutGroup
        switch groupDirection {
        case .horizontal:
            group = .horizontal(layoutSize: groupSize, subitems: items)
        case .vertical:
            group = .vertical(layoutSize: groupSize, subitems: items)
        }
        
        group.interItemSpacing = .fixed(interItemSpacing)
        group.contentInsets = groupInsets
        

        // Создаём секцию и задаём параметры
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = contentInsetsSection
        section.interGroupSpacing = interGroupSpacing
        section.orthogonalScrollingBehavior = scrollingBehavior
        section.decorationItems = decorationItems
        section.boundarySupplementaryItems = boundarySupplementaryItems
        
        return section
    }
}
