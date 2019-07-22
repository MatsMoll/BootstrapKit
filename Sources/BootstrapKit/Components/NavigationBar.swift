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

    let content: View

    public init(@NavigationBarBuilder content: () -> View) {
        self.content = content()
    }

    public var body: View {
        Nav {
            ""
        }
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

        public var body: View {
            Button { icon }.class("navbar-toggler").type(.button).dataToggle("collapse").ariaExpanded(false).ariaLabel("Toggle navigation")
        }
    }
}
