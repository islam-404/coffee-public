//
//  CollectionViewConfiguratorProtocol.swift
//  delivery food
//
//  Created by islam on 04.12.2023.
//

import UIKit

/// Протокол для конфигурирования Header, Footer, Background, Reusable View коллекции.
protocol CollectionViewConfiguratorProtocol {
    
    /// Конфигурирует view с использованием предоставленных данных.
    /// - Parameter view: View, которую необходимо сконфигурировать.
    func configure(view: UICollectionReusableView)
    
    /// Тип view, используемый для регистрации и переиспользования.
    static var reuseId: UICollectionReusableView.Type { get }
}
