//
//  Spinner.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 17/07/2019.
//

import HTMLKit

public struct Spinner : StaticView, AttributeNode {

    public enum Style : String {
        case border
        case grow
    }

    let style: Style
    let color: BootrapStyle
    public var attributes: [HTML.Attribute] = []
    let content: View

    public init(style: Style, color: BootrapStyle, attributes: [HTML.Attribute], content: View) {
        self.attributes = attributes
        self.style = style
        self.color = color
        self.content = content
    }
    public init(style: Style = .border, color: BootrapStyle = .dark, @HTMLBuilder content: (() -> View) = { Span { "Loading..." }.class("sr-only") }) {
        self.attributes = []
        self.style = style
        self.color = color
        self.content = content()
    }

    public var body: View {
        Div {
            content
        }
            .class("spinner-\(style.rawValue) text-\(color.rawValue)")
            .role("status")
            .add(attributes: attributes)
    }

    public func copy(with attributes: [HTML.Attribute]) -> Spinner {
        .init(style: style, color: color, attributes: attributes, content: content)
    }
}
