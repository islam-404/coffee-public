//
//  MenuInteractor.swift
//  coffee
//
//  Created islam on 13.11.2024.
//

final class MenuInteractor {
    
    // MARK: - Properties
    
    weak var output: MenuInteractorOutput?
    
    private let service: ProductsServiceProtocol
    private let storage: ProductCDManager
    
    private var coffeeShopId: Int
    
    // MARK: - Init
    
    init(service: ProductsServiceProtocol, storage: ProductCDManager = .shared, coffeeShopId: Int) {
        self.service = service
        self.storage = storage
        self.coffeeShopId = coffeeShopId
    }
}


// MARK: - MenuInteractorInput
extension MenuInteractor: MenuInteractorInput {
    
    func fetchProducts() {
        service.getProducts(coffeeShopId: coffeeShopId) { result in
            let products = try? result.get()
            self.reloadProducts(products ?? [])
            self.output?.didFetchProducts(products: products ?? [])
        }
    }
    
    func updateProductInStorage(_ product: ProductModel) {
        
        if coffeeShopId == storage.cartCoffeeShopId || storage.cartCoffeeShopId == nil {
            storage.cartCoffeeShopId = coffeeShopId
            if let productCDModel = storage.fetchProduct(by: Int32(product.id)) {
                
                if product.getCount() == 0 {
                    storage.deleteProduct(product: productCDModel)
                } else {
                    productCDModel.count = Int32(product.getCount())
                }
                
            } else {
                storage.addProduct(product)
            }
            
        } else {
            print("Идентификатор кафе не совпадает.")
            product.setCount(0)
            output?.didFailToAddProduct()
            return
        }
    }
    
    func reloadProducts(_ products: [ProductModel]) {
        products.forEach {
            if let productCDModel = self.storage.fetchProduct(by: Int32($0.id)) {
                $0.setCount(Int(productCDModel.count))
            } else {
                $0.setCount(0)
            }
        }
        output?.didFetchProducts(products: products)
    }
    
    func clearCart() {
        storage.clearAllProducts()
    }
}
