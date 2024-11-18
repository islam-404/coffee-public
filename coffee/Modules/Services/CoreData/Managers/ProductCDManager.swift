//
//  ProductCDManager.swift
//  coffee
//
//  Created by islam on 14.11.2024.
//

import CoreData

final class ProductCDManager {
    
    static let shared = ProductCDManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    @UserDefaultManager(key: Constants.CoffeeShopIdKey)
    var cartCoffeeShopId: Int?
    
    private init() {
        container = NSPersistentContainer(name: "ProductContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    private func save() {
        do {
            try context.save()
            print("Saved successfully!")
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
    
    func getProducts() -> [ProductCDModel] {
        
        let request = ProductCDModel.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
            return []
        }
    }
    
    func getProductsCount() -> Int {
        let request = ProductCDModel.fetchRequest()
        
        do {
            let count = try context.count(for: request)
            return count
        } catch let error {
            print("Error counting products: \(error.localizedDescription)")
            return 0
        }
    }
    
    func fetchProduct(by id: Int32) -> ProductCDModel? {
        
        
        let request = ProductCDModel.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(request)
            return results.first
        } catch {
            print("Ошибка при выполнении запроса: \(error.localizedDescription)")
            return nil
        }
    }
    
    func addProduct(_ product: ProductModel) {
        _ = ProductCDModel(product: product)
        save()
    }
    
    func updateProductCount(product: ProductCDModel, newCount: Int) {
        product.count = Int32(newCount)
        save()
    }
    
    func deleteProduct(product: ProductCDModel) {
        context.delete(product)
        save()
        getProductsCount() == 0 ? cartCoffeeShopId = nil : ()
    }
    
    func clearAllProducts() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ProductCDModel.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            save() // Сохраняем изменения после удаления
            cartCoffeeShopId = nil
            print("All products have been deleted successfully!")
        } catch let error {
            print("Error deleting all products: \(error.localizedDescription)")
        }
    }
}

extension ProductCDModel {
    
    convenience init(product: ProductModel) {
        self.init(context: ProductCDManager.shared.context)
        self.uuid = UUID()
        self.id = Int32(product.id)
        self.name = product.name
        self.price = product.price
        self.imageURL = product.imageURL
        self.count = Int32(product.getCount())
    }
}
