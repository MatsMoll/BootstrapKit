//
//  Dropdown.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 16/07/2019.
//

import HTMLKit

public struct Dropdown : HTMLComponent {

    public var body: HTML {
        ""
    }
}


public struct DropdownLink : HTMLComponent, AttributeNode {

    public var attributes: [HTMLAttribute]
    let content: Anchor

    public init(link: HTML, @HTMLBuilder content: () -> HTML) {
        self.content = Anchor.init(attributes: [], content: content())
            .href(link)
        self.attributes = []
    }

    init(attributes: [HTMLAttribute], content: Anchor) {
        self.content = content
        self.attributes = attributes
    }

    public var body: HTML {
        content
            .add(attributes: attributes)
            .class("dropdown-item")
    }

    public func copy(with attributes: [HTMLAttribute]) -> DropdownLink {
        .init(attributes: attributes, content: content)
    }
}
