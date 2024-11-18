//
//  AuthorizationViewController.swift
//  coffee
//
//  Created islam on 03.11.2024.
//

import UIKit
//import ViperUtilites
//import DataConverterUtilites

final class AuthorizationViewController: BaseViewController {
	
    // MARK: - Properties
    
	var output: AuthorizationViewOutput?
    var collectionView: BaseCollectionView?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()

    }
}

// MARK: - AuthorizationViewInput
extension AuthorizationViewController: AuthorizationViewInput {
    
    func setupInitialState() {
        
        view.backgroundColor = .backgroundCof
        title = "Авторизация"
        
        if let collectionView {
            collectionView.hideKeyboardWhenTappedAround()
            collectionView.backgroundColor = .clear
            collectionView.isScrollEnabled = false
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
