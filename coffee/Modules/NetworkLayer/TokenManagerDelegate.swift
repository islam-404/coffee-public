//
//  TokenManagerDelegate.swift
//  coffee
//
//  Created by islam on 10.11.2024.
//

import Foundation

protocol TokenManagerDelegate: AnyObject {
    func didExpireToken()
}
