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


public struct NavigationBar : StaticView {

    let expandOn: SizeClass
    let content: View

    public init(expandOn: SizeClass, @NavigationBarBuilder content: () -> View) {
        self.expandOn = expandOn
        self.content = content()
    }

    public var body: View {
        Nav {
            content
        }.class("navbar navbar-expand-" + expandOn.rawValue)
    }

    public struct Brand : StaticView, NavigationBarContent {

        let link: View
        let content: View

        public init(link: View = "#", @HTMLBuilder content: () -> View) {
            self.link = link
            self.content = content()
        }

        public var body: View {
            Anchor { content }
                .class("navbar-brand")
                .href(link)
        }
    }

    public struct Collapse : StaticView, NavigationBarContent {

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
                    }.class("navbar-nav mr-auto")
                }
                .class("collapse navbar-collapse")
                .id(id)

        }
    }
}
