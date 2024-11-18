//
//  MenuViewController.swift
//  coffee
//
//  Created islam on 13.11.2024.
//

import UIKit
//import ViperUtilites
//import DataConverterUtilites

final class MenuViewController: BaseViewController {
	
    // MARK: - Properties
    
	var output: MenuViewOutput?
    var collectionView: BaseCollectionView?
    
    private let buttonSectionView = ButtonSectionView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
}

// MARK: - MenuViewInput
extension MenuViewController: MenuViewInput {
    
    func setupInitialState() {
        
        title = "Меню"
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
            
            let buttonInputModel = ButtonSectionView.Model(title: "Перейти к оплате", output: delegateButtonSectionView)
            buttonSectionView.configure(with: buttonInputModel)
        }
    }
    
    func updateData(data: CollectionViewModel) {
        collectionView?.updateData(data: data)
    }
    
    func showAlertForMismatchedCoffeeShop(completion: @escaping ((Bool) -> ())) {
        
        /// можно конечно более элегантно обновлять, но для начала и так норм
        collectionView?.reloadData()
        
        /// и это все, и то что в интеракторе тоже, сделал бы по лучше, но так как у нас одно место откуда может добавиться товар поэтому пока так)
        let alert = UIAlertController(
            title: "Смена кафе",
            message: "Вы пытаетесь добавить продукт из другого кафе. Хотите очистить корзину?",
            preferredStyle: .alert
        )
        
        let clearAction = UIAlertAction(title: "Очистить", style: .destructive) { _ in
            completion(true)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            completion(false)
        }
        
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
