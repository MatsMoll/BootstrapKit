//
//  Button.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 15/07/2019.
//

import HTMLKit

public protocol ButtonStylable {
    func style(_ style: BootrapStyle, isOutlined: Bool) -> Self
    func size(_ size: SizeClass) -> Self
    func isActive(_ isActive: Bool) -> Self
}

extension ButtonStylable where Self : AttributeNode {
    public func size(_ size: SizeClass) -> Self {
        size == .all ? self : self.class("btn-\(size.rawValue)")
    }
    
    public func style(_ style: BootrapStyle, isOutlined: Bool = false) -> Self {
        self.class("btn btn\(isOutlined ? "-outline" : "")-\(style.rawValue)")
    }
    
    public func isActive(_ isActive: Bool) -> Self {
        isActive ? self.class("active") : self.class("disabled")
    }
}

extension Button : ButtonStylable {}
extension Anchor : ButtonStylable {}
extension Input : ButtonStylable {}
