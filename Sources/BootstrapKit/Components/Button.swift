//
//  Button.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 15/07/2019.
//

import HTMLKit

public protocol ButtonStylable {
    func button(style: BootstrapStyle, isOutlined: Bool) -> Self
    func button(size: SizeClass) -> Self
    func isActive(_ isActive: Bool) -> Self
}

extension ButtonStylable where Self: GlobalAttributes {
    public func button(size: SizeClass) -> Self {
        size == .all ? self : self.class("btn-\(size.rawValue)")
    }

    public func button(style: BootstrapStyle, isOutlined: Bool = false) -> Self {
        self.class("btn btn\(isOutlined ? "-outline" : "")-\(style.rawValue)")
    }

    public func isActive(_ isActive: Bool) -> Self {
        isActive ? self.class("active") : self.class("disabled")
    }
}

extension Button: ButtonStylable {}
extension Anchor: ButtonStylable {}
extension Input: ButtonStylable {}
