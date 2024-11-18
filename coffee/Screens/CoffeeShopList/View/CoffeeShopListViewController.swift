//
//  CoffeeShopListViewController.swift
//  coffee
//
//  Created islam on 09.11.2024.
//

import UIKit

final class CoffeeShopListViewController: BaseViewController {
	
    // MARK: - Properties
    
	var output: CoffeeShopListViewOutput?
    var collectionView: BaseCollectionView?
    
    private let buttonSectionView = ButtonSectionView()
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }
}

// MARK: - CoffeeShopListViewInput
extension CoffeeShopListViewController: CoffeeShopListViewInput {
    
    func setupInitialState() {
        
        title = "Ближайшие кофейни"
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
            
            let buttonInputModel = ButtonSectionView.Model(title: "На карте", output: delegateButtonSectionView)
            buttonSectionView.configure(with: buttonInputModel)
        }
    }
    
    func updateData(data: CollectionViewModel) {
        collectionView?.updateData(data: data)
    }
}
