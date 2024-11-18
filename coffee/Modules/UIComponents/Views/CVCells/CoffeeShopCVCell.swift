//
//  CoffeeShopCVCell.swift
//  coffee
//
//  Created by islam on 11.11.2024.
//

import UIKit

protocol CoffeeShopCVCellDelegate: AnyObject {
    func didTapCoffeeShop(_ id: Int)
}

final class CoffeeShopCVCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .textCof
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryTextCof
        return label
    }()
    
    private var id: Int?
    weak var delegate: CoffeeShopCVCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let id, let delegate else { return }
        delegate.didTapCoffeeShop(id)
    }
    
    private func setupViews() {
        
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = false
        contentView.backgroundColor = .secondaryCof
        
        // Настройка тени
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 1
        
        contentView.clipsToBounds = false
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.horizontalEdges.bottom.equalToSuperview().inset(10)
        }
    }
}

extension CoffeeShopCVCell: ConfigurableCVCell {
    
    struct Model {
        let coffeeShop: CoffeeShopModel
        let delegate: CoffeeShopCVCellDelegate
    }
    
    func configure(with model: Model) {
        id = model.coffeeShop.id
        delegate = model.delegate
        titleLabel.text = model.coffeeShop.name
        if let distance = model.coffeeShop.point.distance {
            locationLabel.text = "\(distance) km"
        } else {
            locationLabel.text = ""
        }
    }
}
