//
//  ChangeCountView.swift
//  coffee
//
//  Created by islam on 13.11.2024.
//

import UIKit

final class ChangeCountView: UIView {
    
    private let plusButton = BaseButton(rectInsetPoint: 20)
    private let minusButton = BaseButton(rectInsetPoint: 20)
    private let countLabel = UILabel()
    
    private var count = 0 {
        didSet {
            countLabel.text = String(count)
            
            if countBloked == count {
                minusButton.alpha = 0.32
                minusButton.isUserInteractionEnabled = false
            } else {
                minusButton.alpha = 1
                minusButton.isUserInteractionEnabled = true
            }
        }
    }
    private var countBloked = 0
    private let style: Style
    
    var changeCount: ((_ count: Int) -> Void)?
    
    enum Style {
        
        case first
        case second
        
        var buttonColor: UIColor {
            switch self {
            case .first: .secondaryCof
            case .second: .textCof
            }
        }
        
        var textFont: UIFont {
            switch self {
            case .first: .systemFont(ofSize: 14)
            case .second: .boldSystemFont(ofSize: 16)
            }
        }
    }
    
    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        configurable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCount(count: Int) {
        self.count = count
    }
    
    func getCount() -> Int {
        return count
    }
    
    @objc private func plusButtonTap() {
        count += 1
        changeCount?(count)
    }
    
    @objc private func minusButtonTap() {
        guard count != 0, countBloked != count else { return }
        count -= 1
        changeCount?(count)
    }
    
    private func configurable() {
        
        let sizeButtons = 24
        
        addSubview(plusButton)
        plusButton.setImage(UIImage(named: "icPlus"), for: .normal)
        plusButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
        }
        
        addSubview(minusButton)
        minusButton.setImage(UIImage(named: "icMinus"), for: .normal)
        minusButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
        }
        
        addSubview(countLabel)
        countLabel.text = "0"
        countLabel.font = style.textFont
        countLabel.textColor = .textCof
        countLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        [plusButton, minusButton].forEach({
            $0.tintColor = style.buttonColor
            $0.snp.makeConstraints { make in
                make.size.equalTo(sizeButtons)
                make.verticalEdges.equalToSuperview()
            }
        })
        
        plusButton.addTarget(self, action: #selector(plusButtonTap), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTap), for: .touchUpInside)
    }
}
