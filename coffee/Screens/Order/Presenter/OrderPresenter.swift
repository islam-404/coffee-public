//
//  OrderPresenter.swift
//  coffee
//
//  Created islam on 15.11.2024.
//

import Foundation

final class OrderPresenter {
    
    // MARK: - Properties
    
    private weak var view: OrderViewInput?
    private let interactor: OrderInteractorInput
    private let router: OrderRouterInput
    private let inputModel: OrderInputModel
    private let dataConverter: OrderDataConverterInput
    
    // MARK: - Init
    
    init(view: OrderViewInput,
         interactor: OrderInteractorInput,
         router: OrderRouterInput,
         inputModel: OrderInputModel,
         dataConverter: OrderDataConverterInput) 
    {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.inputModel = inputModel
        self.dataConverter = dataConverter
    }
    
}

// MARK: - OrderViewOutput
extension OrderPresenter: OrderViewOutput {
    
    func viewLoaded() {
        view?.setupInitialState()
        let products = interactor.fetchProducts()
        let data = dataConverter.convert(with: products, delegate: self)
        view?.updateData(data: data)
    }
}

// MARK: - OrderInteractorOutput
extension OrderPresenter: OrderInteractorOutput {
    
}

// MARK: - ProductInCartCVCellDelegate
extension OrderPresenter: ProductInCartCVCellDelegate {
    
    func didTapChangeCount(product: ProductCDModel, newCount: Int) {
        interactor.updateProductInStorage(product: product, newCount: newCount, isDeletedProduct: { isDeleted in
            if isDeleted {
                let products = interactor.fetchProducts()
                let data = dataConverter.convert(with: products, delegate: self)
                view?.updateData(data: data)
            }
        })
    }
}

// MARK: - ButtonSectionViewDelegate
extension OrderPresenter: ButtonSectionViewDelegate {
    
    func buttonViewTapped(key: String?) {
        
    }
}
