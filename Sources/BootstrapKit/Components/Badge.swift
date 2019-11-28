//
//  Badge.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 14/07/2019.
//

import HTMLKit

public struct Badge : HTMLComponent {

    public var attributes: [HTMLAttribute]
    let content: HTML
    let isPill: Conditionable

    public init(@HTMLBuilder content: () -> HTML) {
        self.content = content()
        self.attributes = []
        self.isPill = false
    }

    init(isPill: Conditionable, attributes: [HTMLAttribute], content: HTML) {
        self.content = content
        self.attributes = attributes
        self.isPill = isPill
    }

    public var body: HTML {
        Span { content }
            .class("badge" + IF(isPill) { " badge-pill" })
            .add(attributes: attributes)
    }

    public func isPill(_ isPill: Conditionable) -> Badge {
        .init(isPill: isPill, attributes: attributes, content: content)
    }
}

extension Badge {
    public func background(color style: BootstrapStyle) -> Badge {
        self.class("badge-\(style.rawValue)")
    }
}

extension Badge : AttributeNode {
    public func copy(with attributes: [HTMLAttribute]) -> Badge {
        .init(isPill: isPill, attributes: attributes, content: content)
    }
}

extension Anchor {
    public func badge(style: BootstrapStyle, isPill: Conditionable = false) -> Self {
        self.class("badge badge-\(style.rawValue)" + IF(isPill) { " badge-pill" })
    }
}
