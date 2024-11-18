//
//  UserDefaultManager.swift
//  coffee
//
//  Created by islam on 03.11.2024.
//

import Foundation

@propertyWrapper struct UserDefaultManager<Value> {
    
    private let key: String
    private let defaultValue: Value?
    private let container: UserDefaults = .standard
    
    var wrappedValue: Value? {
        get { container.object(forKey: key) as? Value }
        set { container.set(newValue, forKey: key) }
    }
    
    
    init(key: String, defaultValue: Value? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
