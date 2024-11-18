//
//  ButtonCVCell.swift
//  UIComponents
//
//  Created by islam on 05.11.2024.
//

import UIKit
//import DataConverterUtilites

public protocol ButtonCVCellDelegate: AnyObject {
    func buttonViewTapped(key: String?)
}

final class ButtonCVCell: UICollectionViewCell {
    
    private let buttonView = UIButton(type: .system)
    
    private var keyButton: String?
    weak var delegate: ButtonCVCellDelegate?
    private var style: ButtonStyleConfig = .filled
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = false

        // Настройка тени
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 1
        contentView.clipsToBounds = false
        
        contentView.addSubview(buttonView)
        buttonView.titleLabel?.font = .boldSystemFont(ofSize: 18)
        buttonView.layer.cornerRadius = 24
        buttonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    @objc private func buttonTapped() {
        delegate?.buttonViewTapped(key: keyButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        switch style {
            
        case .filled:
            return buttonView.bounds.contains(point) ? buttonView : nil
            
        case .textOnly:
            if let titleLabel = buttonView.titleLabel {
                let pointInsideText = titleLabel.convert(point, from: self)
                return titleLabel.bounds.contains(pointInsideText) ? buttonView : nil
            } else {
                return nil
            }
        }
    }
}

extension ButtonCVCell: ConfigurableCVCell {
    
    public struct Model {
        let key: String?
        let title: String
        let output: ButtonCVCellDelegate
        let style: ButtonStyleConfig
    }
    
    public func configure(with model: Model) {
        keyButton = model.key
        buttonView.setTitle(model.title, for: .normal)
        delegate = model.output
        style = model.style
        model.style.configuration.apply(to: buttonView)
    }
}

