//
//  AbsolutePositionView.swift
//  coffee
//
//  Created by islam on 11.11.2024.
//

import UIKit

struct AbsolutePositionView {
    
    let view: UIView
    let position: Position
    
    enum Position {
        case top
        case bottom
    }
}
