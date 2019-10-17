//
//  NavigationBar.swift
//  App
//
//  Created by Mats Mollestad on 21/07/2019.
//

import HTMLKit

@_functionBuilder
public class NavigationBarBuilder {

    public static func buildBlock(_ children: NavigationBarContent...) -> View {
        return children.reduce([], +)
    }
}

public protocol NavigationBarContent : View {}


public struct NavigationBar: StaticView, AttributeNode {

    public enum Style: String {
        case dark
        case light
    }

    public var attributes: [HTML.Attribute] = []
    let expandOn: SizeClass
    let style: Style
    let content: View

    public init(expandOn: SizeClass, @NavigationBarBuilder content: () -> View) {
        self.expandOn = expandOn
        self.content = content()
        self.style = .light
    }

    init(expandOn: SizeClass, style: Style, content: View, attributes: [HTML.Attribute]) {
        self.expandOn = expandOn
        self.style = style
        self.content = content
        self.attributes = attributes
    }

    public var body: View {
        Nav {
            content
        }
        .class("navbar navbar-expand-" + expandOn.rawValue + " navbar-\(style.rawValue)")
        .add(attributes: attributes)
    }

    public func navigationBar(style: Style) -> NavigationBar {
        .init(expandOn: expandOn, style: style, content: content, attributes: attributes)
    }

    public func copy(with attributes: [HTML.Attribute]) -> NavigationBar {
        .init(expandOn: expandOn, style: style, content: content, attributes: attributes)
    }

    public struct Brand: StaticView, NavigationBarContent, AttributeNode {

        public var attributes: [HTML.Attribute] = []
        let link: View
        let content: View

        public init(link: View = "#", @HTMLBuilder content: () -> View) {
            self.link = link
            self.content = content()
        }

        init(link: View, content: View, attributes: [HTML.Attribute]) {
            self.link = link
            self.content = content
            self.attributes = attributes
        }

        public var body: View {
            Anchor { content }
                .class("navbar-brand")
                .href(link)
                .add(attributes: attributes)
        }

        public func copy(with attributes: [HTML.Attribute]) -> NavigationBar.Brand {
            .init(link: link, content: content, attributes: attributes)
        }
    }

    public struct Collapse: StaticView, NavigationBarContent {

        let icon: View
        let content: View
        let id: String

        public init(icon: View = Span().class("navbar-toggler-icon"), id: String = "navbarSupportedContent", @HTMLBuilder content: () -> View) {
            self.icon = icon
            self.content = content()
            self.id = id
        }

        public var body: View {
            Button { icon }
                .type(.button)
                .class("navbar-toggler")
                .data(for: "toggle", value: "collapse")
                .aria(for: "expanded", value: false)
                .aria(for: "label", value: "Toggle navigation")
                .aria(for: "target", value: HTML.Identifier.id(id))
                .aria(for: "controls", value: id)
                +
                Div {
                    UnorderdList {
                        content
                    }.class("navbar-nav ml-auto")
                }
                .class("collapse navbar-collapse")
                .id(id)

        }
    }
}
