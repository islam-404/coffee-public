//
//  RegistrationViewController.swift
//  coffee
//
//  Created islam on 17.11.2024.
//

import UIKit

final class RegistrationViewController: BaseViewController {
	
    // MARK: - Properties
    
	var output: RegistrationViewOutput?
    var collectionView: BaseCollectionView?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }
}

// MARK: - RegistrationViewInput
extension RegistrationViewController: RegistrationViewInput {
    
    func setupInitialState() {
        
        view.backgroundColor = .backgroundCof
        title = "Регистрация"
        
        if let collectionView {
            collectionView.hideKeyboardWhenTappedAround()
            collectionView.backgroundColor = .clear
//            collectionView.isScrollEnabled = false
            view.addSubview(collectionView)
            collectionView.snp.makeConstraints({ make in
                make.edges.equalTo(view.safeAreaLayoutGuide)
            })
        }
    }
    
    func updateData(data: CollectionViewModel) {
        collectionView?.updateData(data: data)
    }
}
