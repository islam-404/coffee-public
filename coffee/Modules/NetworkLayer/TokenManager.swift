//
//  TokenManager.swift
//  NetworkLayer
//
//  Created by islam on 03.11.2024.
//

import Security
import Foundation

public class TokenManager {
    
    public static let shared = TokenManager()
    private let key: String = "User_JSON_Web_Token"
    
    private var expirationTime: TimeInterval?
    
    weak var delegate: TokenManagerDelegate?
    
    var token: String? {
        get { getToken() }
        set {
            if saveToken(newValue) {
                expirationTime = extractExpirationTime(from: token)
            }
        }
    }
    
    var isLifeToken: Bool {
//        return false
        guard let expirationTime = expirationTime else { return false }
        let expirationDate = Date(timeIntervalSince1970: expirationTime)
        let remainingTime = expirationDate.timeIntervalSinceNow

        return remainingTime > 10
    }
    
    private init() {
        expirationTime = extractExpirationTime(from: getToken())
    }
    
    private func extractExpirationTime(from token: String?) -> TimeInterval? {
        
        guard let token else { return nil}
        let components = token.split(separator: ".")
        guard components.count == 3 else { return nil }
        
        let payload = components[1]
        
        var base64 = String(payload)
        let paddingLength = 4 - base64.count % 4
        if paddingLength < 4 {
            base64.append(String(repeating: "=", count: paddingLength))
        }
        
        guard let payloadData = Data(base64Encoded: base64),
              let payloadJson = try? JSONSerialization.jsonObject(with: payloadData, options: []),
              let payloadDict = payloadJson as? [String: Any] else {
            return nil
        }
        
        return payloadDict["exp"] as? TimeInterval
    }
    
    private func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let data = item as? Data else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    private func saveToken(_ token: String?) -> Bool {
        guard let tokenData = token?.data(using: .utf8) else {
            return false
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: tokenData
        ]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
}
