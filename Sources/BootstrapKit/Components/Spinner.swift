//
//  Spinner.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 17/07/2019.
//

import HTMLKit

public struct Spinner : HTMLComponent, AttributeNode {

    public enum Style : String {
        case border
        case grow
    }

    let style: Style
    let color: BootstrapStyle
    public var attributes: [HTMLAttribute] = []
    let content: HTML

    public init(style: Style, color: BootstrapStyle, attributes: [HTMLAttribute], content: HTML) {
        self.attributes = attributes
        self.style = style
        self.color = color
        self.content = content
    }
    public init(style: Style = .border, color: BootstrapStyle = .dark, @HTMLBuilder content: (() -> HTML) = { Span { "Loading..." }.class("sr-only") }) {
        self.attributes = []
        self.style = style
        self.color = color
        self.content = content()
    }

    public var body: HTML {
        Div {
            content
        }
            .class("spinner-\(style.rawValue) text-\(color.rawValue)")
            .role("status")
            .add(attributes: attributes)
    }

    public func copy(with attributes: [HTMLAttribute]) -> Spinner {
        .init(style: style, color: color, attributes: attributes, content: content)
    }
}
