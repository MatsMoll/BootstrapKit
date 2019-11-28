//
//  NavigationBar.swift
//  App
//
//  Created by Mats Mollestad on 21/07/2019.
//

import HTMLKit

@_functionBuilder
public class NavigationBarBuilder {

    public static func buildBlock(_ children: NavigationBarContent...) -> HTML {
        return children.reduce([], +)
    }
}

public protocol NavigationBarContent : HTML {}


public struct NavigationBar: HTMLComponent, AttributeNode {

    public enum Style: String {
        case dark
        case light
    }

    public var attributes: [HTMLAttribute] = []
    let expandOn: SizeClass
    let style: Style
    let content: HTML

    public init(expandOn: SizeClass, @NavigationBarBuilder content: () -> HTML) {
        self.expandOn = expandOn
        self.content = content()
        self.style = .light
    }

    init(expandOn: SizeClass, style: Style, content: HTML, attributes: [HTMLAttribute]) {
        self.expandOn = expandOn
        self.style = style
        self.content = content
        self.attributes = attributes
    }

    public var body: HTML {
        Nav {
            content
        }
        .class("navbar navbar-expand-" + expandOn.rawValue + " navbar-\(style.rawValue)")
        .add(attributes: attributes)
    }

    public func navigationBar(style: Style) -> NavigationBar {
        .init(expandOn: expandOn, style: style, content: content, attributes: attributes)
    }

    public func copy(with attributes: [HTMLAttribute]) -> NavigationBar {
        .init(expandOn: expandOn, style: style, content: content, attributes: attributes)
    }

    public struct Brand: HTMLComponent, NavigationBarContent, AttributeNode {

        public var attributes: [HTMLAttribute] = []
        let link: HTML
        let content: HTML

        public init(link: HTML = "#", @HTMLBuilder content: () -> HTML) {
            self.link = link
            self.content = content()
        }

        init(link: HTML, content: HTML, attributes: [HTMLAttribute]) {
            self.link = link
            self.content = content
            self.attributes = attributes
        }

        public var body: HTML {
            Anchor { content }
                .class("navbar-brand")
                .href(link)
                .add(attributes: attributes)
        }

        public func copy(with attributes: [HTMLAttribute]) -> NavigationBar.Brand {
            .init(link: link, content: content, attributes: attributes)
        }
    }

    public struct Collapse: HTMLComponent, NavigationBarContent {

        let button: AddableAttributeNode
        let content: HTML
        let id: String

        public init(button: AddableAttributeNode? = nil, id: String = "navbarResponsive", @HTMLBuilder content: () -> HTML) {
            self.content = content()
            self.id = id
            self.button = button ?? Button {
                Span().class("navbar-toggler-icon")
            }
                .type(.button)
                .class("navbar-toggler")
                .aria(for: "label", value: "Toggle navigation")
        }

        public var body: HTML {
            button
                .data(for: "toggle", value: "collapse")
                .aria(for: "expanded", value: false)
                .aria(for: "target", value: HTMLIdentifier.id(id))
                .aria(for: "controls", value: id) +
            Div {
                UnorderdList {
                    content
                }
                .class("navbar-nav ml-auto")
            }
            .class("collapse navbar-collapse")
            .id(id)
        }
    }
}
