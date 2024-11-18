//
//  UIScrollView + extension.swift
//  coffee
//
//  Created by islam on 09.11.2024.
//

import UIKit

extension UIScrollView {

    /// Добавляем возможность скрывать клавиатуру при тапе по экрану
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Чтобы тапы на другие элементы продолжали работать
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}
