//
//  Dropdown.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 16/07/2019.
//

import HTMLKit

public struct Dropdown : StaticView {

    public var body: View {
        ""
    }
}


public struct DropdownLink : StaticView, AttributeNode {

    public var attributes: [HTML.Attribute]
    let content: Anchor

    public init(link: View, @HTMLBuilder content: () -> View) {
        self.content = Anchor.init(attributes: [], content: content())
            .href(link)
        self.attributes = []
    }

    init(attributes: [HTML.Attribute], content: Anchor) {
        self.content = content
        self.attributes = attributes
    }

    public var body: View {
        content
            .add(attributes: attributes)
            .class("dropdown-item")
    }

    public func copy(with attributes: [HTML.Attribute]) -> DropdownLink {
        .init(attributes: attributes, content: content)
    }
}
