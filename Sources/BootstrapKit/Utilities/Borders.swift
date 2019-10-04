//
//  Borders.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 19/07/2019.
//

import HTMLKit

public enum BorderRadiusStyle : String {
    case rounded = "rounded"
    case roundedTop = "rounded-top"
    case roundedBottom = "rounded-bottom"
    case roundedRight = "rounded-right"
    case roundedLeft = "rounded-left"
    case roundedCircle = "rounded-circle"
    case roundedPill = "rounded-pill"
    case roundedZero = "rounded-0"
}


extension GlobalAttributes {
    public func border(color: BootrapStyle) -> Self {
        self.class("border border-\(color.rawValue)")
    }

    public func borderRadius(_ style: BorderRadiusStyle) -> Self {
        self.class(style.rawValue)
    }

    public func borderRadius(size: SizeClass) -> Self {
        size == .all ? self : self.class("rounded-\(size.rawValue)")
    }
}
