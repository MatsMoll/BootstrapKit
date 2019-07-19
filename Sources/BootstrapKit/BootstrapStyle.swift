//
//  BootstrapStyle.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 14/07/2019.
//

import HTMLKit

public enum BootrapStyle : String {
    case primary
    case secondary
    
    case light
    case dark
    
    case info
    case success
    case danger
    case warning
}

public protocol BootstrapStyleable {
    func style(_ style: BootrapStyle) -> Self
}
