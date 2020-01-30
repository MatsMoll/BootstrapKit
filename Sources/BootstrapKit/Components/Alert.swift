//
//  Alert.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 13/07/2019.
//

import HTMLKit

extension BootstrapStyle {
    fileprivate var alertClass: String {
        "alert alert-\(rawValue) bg-\(rawValue)"
    }
}

public struct Alert: HTMLComponent {

    public var attributes: [HTMLAttribute]
    let content: HTML
    let isDisimissable: Conditionable
    let style: TemplateValue<BootstrapStyle>

    public init(@HTMLBuilder content: () -> HTML) {
        self.isDisimissable = true
        self.content = content()
        self.attributes = []
        self.style = .constant(.primary)
    }

    init(isDisimissable: Conditionable, style: TemplateValue<BootstrapStyle>, attributes: [HTMLAttribute], content: HTML) {
        self.attributes = attributes
        self.content = content
        self.isDisimissable = isDisimissable
        self.style = style
    }

    public var body: HTML {
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
            .class(style.alertClass + IF(isDisimissable) { " fade show" })
            .role("alert")
            .add(attributes: attributes)
    }

    public func isDismissable(_ isDismissable: Conditionable) -> Alert {
        .init(isDisimissable: isDismissable, style: style, attributes: attributes, content: content)
    }
}

extension Alert : AttributeNode {
    public func copy(with attributes: [HTMLAttribute]) -> Alert {
        .init(isDisimissable: isDisimissable, style: style, attributes: attributes, content: content)
    }
}

extension Alert {
    public func background(color style: BootstrapStyle) -> Alert {
        .init(isDisimissable: isDisimissable, style: .constant(style), attributes: attributes, content: content)
    }

    public func background(color style: TemplateValue<BootstrapStyle>) -> Alert {
        .init(isDisimissable: isDisimissable, style: style, attributes: attributes, content: content)
    }
}
