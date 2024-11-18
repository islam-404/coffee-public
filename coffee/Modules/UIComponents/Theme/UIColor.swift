//
//  UIColor.swift
//  UIComponents
//
//  Created by islam on 05.11.2024.
//

import UIKit

extension UIColor {
    
    /// #342D1A
    static let tintColorCof = hexStringToUIColor(hex: "#342D1A")
    
    /// #846340
    static let textCof = hexStringToUIColor(hex: "#846340")
    /// #AF9479
    static let secondaryTextCof = hexStringToUIColor(hex: "#AF9479")
    
    /// #F6E5D1
    static let secondaryCof = hexStringToUIColor(hex: "#F6E5D1")
    /// #FFFFFF
    static let backgroundCof = hexStringToUIColor(hex: "#FFFFFF")
    
    static let redCof = UIColor.red
}

// MARK: - UIColor + hex
extension UIColor {
    public static func hexStringToUIColor(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
