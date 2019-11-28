//
//  Card.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 15/07/2019.
//

import HTMLKit

public struct Card : HTMLComponent {

    public var attributes: [HTMLAttribute]

    let image: Img?
    let content: HTML
    let subBody: HTML?

    public init(@HTMLBuilder content: () -> HTML) {
        self.image = nil
        self.content = content()
        self.subBody = nil
        self.attributes = []
    }

    init(image: Img?, content: HTML, subBody: HTML?, attributes: [HTMLAttribute]) {
        self.image = image
        self.content = content
        self.subBody = subBody
        self.attributes = attributes
    }

    public var body: HTML {
        Div {
            image?.class("card-img-top")
            Div { content }.class("card-body")
            subBody ?? ""
        }
        .class("card")
        .add(attributes: attributes)
    }

    public func image(_ image: Img) -> Card {
        Card(image: image, content: content, subBody: subBody, attributes: attributes)
    }

    public func sub(@HTMLBuilder body subBody: () -> HTML) -> Card {
        Card(image: image, content: content, subBody: subBody(), attributes: attributes)
    }
}

extension Card: AttributeNode {
    public func copy(with attributes: [HTMLAttribute]) -> Card {
        .init(image: image, content: content, subBody: subBody, attributes: attributes)
    }
}
