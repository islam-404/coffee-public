//
//  BaseButton.swift
//  coffee
//
//  Created by islam on 13.11.2024.
//

import UIKit

class BaseButton: UIButton {
    
    private let rectInsetPoint: CGFloat
    
    init(rectInsetPoint: CGFloat) {
        self.rectInsetPoint = rectInsetPoint
        super.init(frame: .zero)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let area = CGRectInset(self.bounds, -rectInsetPoint, -rectInsetPoint)
        return CGRectContainsPoint(area, point)
    }
    
    // Настраиваем кнопку
    private func configureButton() {
        // Добавляем действия для изменения прозрачности при нажатии и отпускании
        addTarget(self, action: #selector(didTouchDown), for: .touchDown)
        addTarget(self, action: #selector(didTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }

    // Метод для обработки нажатия (делаем кнопку более прозрачной)
    @objc private func didTouchDown() {
        alpha = 0.5 // Полу-прозрачность при нажатии
    }

    // Метод для обработки отпускания (возвращаем исходную прозрачность)
    @objc private func didTouchUp() {
        alpha = 1.0 // Исходная непрозрачность
    }
}
