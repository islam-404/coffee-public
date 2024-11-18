//
//  MenuInteractorInput.swift
//  coffee
//
//  Created islam on 13.11.2024.
//

protocol MenuInteractorInput {
    func fetchProducts()
    func updateProductInStorage(_ product: ProductModel)
    func reloadProducts(_ products: [ProductModel])
    func clearCart()
}
