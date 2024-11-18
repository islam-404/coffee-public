//
//  PaddedTextField.swift
//  UIComponents
//
//  Created by islam on 05.11.2024.
//

import UIKit

final class PaddedTextField: UITextField {
    // Задаем отступы для текста
    var textPadding = UIEdgeInsets.zero
    
    // Определяем положение текста в обычном состоянии
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    // Определяем положение текста при редактировании
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}
