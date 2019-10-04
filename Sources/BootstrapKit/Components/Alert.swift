//
//  Alert.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 13/07/2019.
//

import HTMLKit

public struct Alert : StaticView {

    public var attributes: [HTML.Attribute]
    let content: View
    let isDisimissable: Conditionable
    let style: BootrapStyle

    public init(@HTMLBuilder content: () -> View) {
        self.isDisimissable = true
        self.content = content()
        self.attributes = []
        self.style = .primary
    }

    init(isDisimissable: Conditionable, style: BootrapStyle, attributes: [HTML.Attribute], content: View) {
        self.attributes = attributes
        self.content = content
        self.isDisimissable = isDisimissable
        self.style = style
    }

    public var body: View {
        Div {
            content
            IF(isDisimissable) {
                Button {
                    Span { "&times;" }
                        .aria(for: "hidden", value: true)
                }
                    .type(.button)
                    .class("close")
                    .data(for: "dismiss", value: "alert")
                    .aria(for: "label", value: "Close")
            }
        }
            .class("alert alert-\(style.rawValue)" + IF(isDisimissable) { " fade show" })
            .role("alert")
            .add(attributes: attributes)
    }

    public func isDismissable(_ isDismissable: Conditionable) -> Alert {
        .init(isDisimissable: isDismissable, style: style, attributes: attributes, content: content)
    }
}

extension Alert : AttributeNode {
    public func copy(with attributes: [HTML.Attribute]) -> Alert {
        .init(isDisimissable: isDisimissable, style: style, attributes: attributes, content: content)
    }
}

extension Alert : BootstrapStyleable {
    public func style(_ style: BootrapStyle) -> Alert {
        .init(isDisimissable: isDisimissable, style: style, attributes: attributes, content: content)
    }
}
