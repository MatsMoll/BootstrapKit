//
//  Card.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 15/07/2019.
//

import HTMLKit

public struct Card : StaticView {

    public var attributes: [HTML.Attribute]

    let image: Img?
    let content: View

    public init(image: Img? = nil, @HTMLBuilder content: () -> View) {
        self.image = image
        self.content = content()
        self.attributes = []
    }

    init(image: Img?, content: View, attributes: [HTML.Attribute]) {
        self.image = image
        self.content = content
        self.attributes = attributes
    }

    public var body: View {
        Div {
            image?.class("card-img-top")
            Div { content }.class("card-body")
        }.class("card")
    }
}

extension Card : AttributeNode {
    public func copy(with attributes: [HTML.Attribute]) -> Card {
        .init(image: image, content: content, attributes: attributes)
    }
}
