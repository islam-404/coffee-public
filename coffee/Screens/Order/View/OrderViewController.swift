//
//  OrderViewController.swift
//  coffee
//
//  Created islam on 15.11.2024.
//

import UIKit
//import ViperUtilites
//import DataConverterUtilites

final class OrderViewController: BaseViewController {
	
    // MARK: - Properties
    
	var output: OrderViewOutput?
    var collectionView: BaseCollectionView?
    
    private let buttonSectionView = ButtonSectionView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }
}

// MARK: - OrderViewInput
extension OrderViewController: OrderViewInput {
    
    func setupInitialState() {
        
        title = "Ваш заказ"
        view.backgroundColor = .backgroundCof
        
        guard let collectionView else { return }
    
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        })
        
        view.addSubview(buttonSectionView)
        buttonSectionView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        if let delegateButtonSectionView = output as? ButtonSectionViewDelegate {
            
            let buttonInputModel = ButtonSectionView.Model(title: "Оплатить", output: delegateButtonSectionView)
            buttonSectionView.configure(with: buttonInputModel)
        }
    }
    
    func updateData(data: CollectionViewModel) {
        collectionView?.updateData(data: data)
    }
}
