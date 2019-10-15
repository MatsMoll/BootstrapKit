//
//  Badge.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 14/07/2019.
//

import HTMLKit

public struct Badge : StaticView {

    public var attributes: [HTML.Attribute]
    let style: BootstrapStyle
    let content: View
    let isPill: Conditionable

    public init(@HTMLBuilder content: () -> View) {
        self.content = content()
        self.style = .primary
        self.attributes = []
        self.isPill = false
    }

    init(style: BootstrapStyle, isPill: Conditionable, attributes: [HTML.Attribute], content: View) {
        self.style = style
        self.content = content
        self.attributes = attributes
        self.isPill = isPill
    }

    public var body: View {
        Span { content }
            .class("badge badge-\(style.rawValue)" + IF(isPill) { " badge-pill" })
            .add(attributes: attributes)
    }

    public func isPill(_ isPill: Conditionable) -> Badge {
        .init(style: style, isPill: isPill, attributes: attributes, content: content)
    }
}

extension Badge {
    public func background(color style: BootstrapStyle) -> Badge {
        .init(style: style, isPill: isPill, attributes: attributes, content: content)
    }
}

extension Badge : AttributeNode {
    public func copy(with attributes: [HTML.Attribute]) -> Badge {
        .init(style: style, isPill: isPill, attributes: attributes, content: content)
    }
}

extension Anchor {
    public func badge(style: BootstrapStyle, isPill: Conditionable = false) -> Self {
        self.class("badge badge-\(style.rawValue)" + IF(isPill) { " badge-pill" })
    }
}
