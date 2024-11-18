//
//  ConstantLayoutSection.swift
//  coffee
//
//  Created by islam on 15.11.2024.
//

import UIKit

enum ConstantLayoutSection {
    
    static let coffeeShopAndOrderSection = SectionConfig()
        .addItem(w: .fractionalWidth(1), h: .estimated(71))
        .setGroup(w: .fractionalWidth(1), h: .fractionalHeight(1))
        .setGroupInsets(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
        .setGroupSpacing(6)
        .build()
    
    static let registrationAndAuthSection = SectionConfig()
        .addItem(w: .fractionalWidth(1), h: .estimated(70))
        .setGroup(w: .fractionalWidth(1), h: .fractionalHeight(1))
        .setGroupInsets(.init(top: 0, leading: 18, bottom: 0, trailing: 18))
        .setGroupSpacing(6)
        .setSection(insets: .zero, spacing: 0)
        .build()
    
    
    static func calculateTopInsetForCenteredSection(sectionHeight: CGFloat) -> CGFloat {
        let topHeigthSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        let bottomHeigthSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        let screenHeight = UIScreen.main.bounds.height - topHeigthSafeArea - bottomHeigthSafeArea
        let availableHeight = screenHeight / 2
        let topInset = availableHeight - sectionHeight
        
        return topInset
    }
}
