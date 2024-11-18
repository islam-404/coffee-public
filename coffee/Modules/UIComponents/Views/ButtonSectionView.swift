//
//  ButtonSectionView.swift
//  coffee
//
//  Created by islam on 11.11.2024.
//

import UIKit

protocol ButtonSectionViewDelegate: AnyObject {
    func buttonViewTapped(key: String?)
}

final class ButtonSectionView: UIView {
    
    private let buttonView = UIButton(type: .system)
    
    private var keyButton: String?
    weak var delegate: ButtonSectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .backgroundCof

        addSubview(buttonView)
        buttonView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        buttonView.layer.shadowOffset = CGSize(width: 0, height: 2)
        buttonView.layer.shadowRadius = 4
        buttonView.layer.shadowOpacity = 1
        buttonView.clipsToBounds = false
        
        buttonView.setTitleColor(.secondaryCof, for: .normal)
        buttonView.titleLabel?.font = .boldSystemFont(ofSize: 18)
        buttonView.backgroundColor = .tintColorCof
        buttonView.layer.cornerRadius = 24
        buttonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttonView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.setLineWidth(1.0)
        
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: rect.width, y: 0))
        
        context.strokePath()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func buttonTapped() {
        delegate?.buttonViewTapped(key: keyButton)
    }
}

extension ButtonSectionView {
    
    struct Model {
        let key: String?
        let title: String
        let output: ButtonSectionViewDelegate
        
        init(key: String? = nil, title: String, output: ButtonSectionViewDelegate) {
            self.key = key
            self.title = title
            self.output = output
        }
    }
    
    func configure(with model: Model) {
        keyButton = model.key
        buttonView.setTitle(model.title, for: .normal)
        delegate = model.output
    }
}
