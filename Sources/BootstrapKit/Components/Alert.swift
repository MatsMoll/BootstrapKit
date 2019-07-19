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
    let isDisimissable: Bool
    let style: BootrapStyle
    
    public init(@HTMLBuilder content: () -> View) {
        self.isDisimissable = true
        self.content = content()
        self.attributes = []
        self.style = .primary
    }
    
    init(isDisimissable: Bool, style: BootrapStyle, attributes: [HTML.Attribute], content: View) {
        self.attributes = attributes
        self.content = content
        self.isDisimissable = isDisimissable
        self.style = style
    }
    
    public var body: View {
        Div {
            content
            IF(.constant(isDisimissable)) {
                Button {
                    Span { "&times;" }
                        .ariaHidden(true)
                }
                    .type(.button)
                    .class("close")
                    .dataDismiss("alert")
                    .ariaLabel("Close")
            }
        }
            .class("alert alert-\(style.rawValue)")
            .role("alert")
            .add(attributes: attributes)
    }
    
    public func isDismissable(_ isDismissable: Bool) -> Alert {
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
