//
//  MenuPresenter.swift
//  coffee
//
//  Created islam on 13.11.2024.
//

import Foundation

final class MenuPresenter {
    
    // MARK: - Properties
    
    private weak var view: MenuViewInput?
    private let interactor: MenuInteractorInput
    private let router: MenuRouterInput
    private let inputModel: MenuInputModel
    private let dataConverter: MenuDataConverterInput
    
    private var products: [ProductModel] = []
    
    // MARK: - Init
    
    init(view: MenuViewInput,
         interactor: MenuInteractorInput,
         router: MenuRouterInput,
         inputModel: MenuInputModel,
         dataConverter: MenuDataConverterInput) 
    {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.inputModel = inputModel
        self.dataConverter = dataConverter
    }
    
}

// MARK: - MenuViewOutput
extension MenuPresenter: MenuViewOutput {
    
    func viewLoaded() {
        view?.setupInitialState()
        interactor.fetchProducts()
    }
    
    func viewWillAppear() {
        interactor.reloadProducts(products)
    }
}

// MARK: - MenuInteractorOutput
extension MenuPresenter: MenuInteractorOutput {
    
    func didFetchProducts(products: [ProductModel]) {
        self.products = products
        let productsViewModel = dataConverter.convert(with: products, delegate: self)
        view?.updateData(data: productsViewModel)
    }
    
    func didFailToAddProduct() {
        view?.showAlertForMismatchedCoffeeShop { isClearCart in
            if isClearCart {
                self.interactor.clearCart()
            }
        }
    }
}

// MARK: - ProductCVCellDelegate
extension MenuPresenter: ProductCVCellDelegate {
    
    func didTapChangeCount(_ id: Int, index: Int, count: Int) {
        guard let product = products[safe: index],
              product.id == id
        else { return }
        product.setCount(count)
        interactor.updateProductInStorage(product)
    }
}

// MARK: - ButtonSectionViewDelegate
extension MenuPresenter: ButtonSectionViewDelegate {

    func buttonViewTapped(key: String?) {
        router.openOrderScreen(inputModel: OrderInputModel())
    }
}
