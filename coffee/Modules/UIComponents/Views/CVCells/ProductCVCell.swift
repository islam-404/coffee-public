//
//  ProductCVCell.swift
//  coffee
//
//  Created by islam on 13.11.2024.
//

import UIKit
import Kingfisher

protocol ProductCVCellDelegate: AnyObject {
    func didTapChangeCount(_ id: Int, index: Int, count: Int)
}

final class ProductCVCell: UICollectionViewCell {
    
    private let conteinerView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeCountView = ChangeCountView(style: .first)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
        // Настройка тени
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 1
        
        contentView.clipsToBounds = false
        
        contentView.addSubview(conteinerView)
        conteinerView.layer.zPosition = 999
        conteinerView.layer.cornerRadius = 5
        conteinerView.frame = contentView.bounds
        conteinerView.backgroundColor = .white
        conteinerView.clipsToBounds = true
        
        conteinerView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(137)
        }
        
        conteinerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(11)
        }
        
        conteinerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.bottom.equalToSuperview().inset(11)
        }
        
        conteinerView.addSubview(changeCountView)
        changeCountView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(7)
            make.width.equalTo(77)
        }
    }
}


extension ProductCVCell: ConfigurableCVCell {
    
    struct Model {
        let index: Int
        let product: ProductModel
        let delegate: ProductCVCellDelegate
    }
    
    func configure(with model: Model) {
        
        titleLabel.text = model.product.name
        priceLabel.text = String(model.product.price)
        imageView.kf.setImage(with: URL(string: model.product.imageURL))
        
        changeCountView.setCount(count: model.product.getCount())
        changeCountView.changeCount = { count in
            model.delegate.didTapChangeCount(model.product.id, index: model.index, count: count)
        }
    }
}
