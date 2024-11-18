//
//  OrderInteractorInput.swift
//  coffee
//
//  Created islam on 15.11.2024.
//

protocol OrderInteractorInput {
    func fetchProducts() -> [ProductCDModel]
    func updateProductInStorage(product: ProductCDModel, newCount: Int, isDeletedProduct: ((Bool) -> ()))
}
