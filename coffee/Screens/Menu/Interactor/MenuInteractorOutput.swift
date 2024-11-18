//
//  MenuInteractorOutput.swift
//  coffee
//
//  Created islam on 13.11.2024.
//

protocol MenuInteractorOutput: AnyObject {
    func didFetchProducts(products: [ProductModel])
    func didFailToAddProduct()
}
