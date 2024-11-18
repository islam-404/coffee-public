//
//  CustomPlacemarkView.swift
//  coffee
//
//  Created by islam on 13.11.2024.
//

import UIKit


final class CustomPlacemarkView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icСupOfCoffee")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .secondaryCof
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialState() {
        
        backgroundColor = .tintColorCof
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4

//        snp.makeConstraints { make in
//            make.size.equalTo(58)
//        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
