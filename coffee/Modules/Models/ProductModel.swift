//
//  ProductModel.swift
//  coffee
//
//  Created by islam on 13.11.2024.
//

import Foundation

final class ProductModel: Decodable {
    
    let id: Int
    let name: String
    let imageURL: String
    let price: Double
    
    private var count: Int?
    
    init(id: Int, name: String, imageURL: String, price: Double) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.price = price
    }
    
    func setCount(_ count: Int) {
        self.count = count
    }
    
    func getCount() -> Int { count ?? 0 }
}
