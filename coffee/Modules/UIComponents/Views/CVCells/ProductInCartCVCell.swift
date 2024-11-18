//
//  ProductInCartCVCell.swift
//  coffee
//
//  Created by islam on 15.11.2024.
//

import UIKit

protocol ProductInCartCVCellDelegate: AnyObject {
    func didTapChangeCount(product: ProductCDModel, newCount: Int)
}

final class ProductInCartCVCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeCountView = ChangeCountView(style: .second)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
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
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .textCof
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(priceLabel)
        priceLabel.font = .systemFont(ofSize: 14, weight: .regular)
        priceLabel.textColor = .secondaryTextCof
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.horizontalEdges.bottom.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(changeCountView)
        changeCountView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(77)
        }
    }
}

extension ProductInCartCVCell: ConfigurableCVCell {
    
    struct Model {
        let product: ProductCDModel
        let delegate: ProductInCartCVCellDelegate
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.product.name
        priceLabel.text = String(model.product.price)
        
        changeCountView.setCount(count: Int(model.product.count))
        changeCountView.changeCount = { count in
            model.delegate.didTapChangeCount(product: model.product, newCount: count)
        }
    }
}
