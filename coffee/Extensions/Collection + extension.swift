//
//  Collection + extension.swift
//  coffee
//
//  Created by islam on 14.11.2024.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
