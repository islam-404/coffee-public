//
//  ElementKindCVType.swift
//  DataConverterUtilites
//
//  Created by islam on 13.09.2024.
//

/// Перечисление строковых значений для типов элементов в `UICollectionView`.
///
/// Используется для идентификации различных типов supplementary views в коллекции.
public enum ElementKindCVType {
    
    /// Идентификатор для заголовка секции в `UICollectionView`.
    public static let header = "Header"
    
    /// Идентификатор для футера секции в `UICollectionView`.
    public static let footer = "Footer"
    
    /// Идентификатор для фонового элемента секции в `UICollectionView`.
    public static let background = "Background"
}

