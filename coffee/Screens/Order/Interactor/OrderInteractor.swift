//
//  OrderInteractor.swift
//  coffee
//
//  Created islam on 15.11.2024.
//

final class OrderInteractor {
    
    // MARK: - Properties
    
    weak var output: OrderInteractorOutput?
    
    private let storage: ProductCDManager
    
    
    // MARK: - Init
    
    init(storage: ProductCDManager = .shared) {
        self.storage = storage
    }
    
}


// MARK: - OrderInteractorInput
extension OrderInteractor: OrderInteractorInput {
    
    func fetchProducts() -> [ProductCDModel] {
        storage.getProducts()
    }
    
    func updateProductInStorage(product: ProductCDModel, newCount: Int, isDeletedProduct: ((Bool) -> ())) {
        
        if newCount > 0 {
            storage.updateProductCount(product: product, newCount: newCount)
        } else {
            storage.deleteProduct(product: product)
            isDeletedProduct(true)
        }
    }
    
    
}
