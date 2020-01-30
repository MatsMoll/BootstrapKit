//
//  Card.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 15/07/2019.
//

import HTMLKit

public struct Card : HTMLComponent {

    public var attributes: [HTMLAttribute]
    var headerAttributes: [HTMLAttribute]
    var footerAttributes: [HTMLAttribute]
    var bodyAttributes: [HTMLAttribute]

    let header: HTML?
    let content: HTML
    let footer: HTML?

    public init(@HTMLBuilder content: () -> HTML) {
        self.header = nil
        self.content = content()
        self.footer = nil
        self.attributes = []
        self.headerAttributes = []
        self.bodyAttributes = []
        self.footerAttributes = []
    }

    init(header: HTML?, content: HTML, footer: HTML?, attributes: [HTMLAttribute], headerAttributes: [HTMLAttribute], bodyAttributes: [HTMLAttribute], footerAttributes: [HTMLAttribute]) {
        self.header = header
        self.content = content
        self.footer = footer
        self.attributes = attributes
        self.headerAttributes = headerAttributes
        self.bodyAttributes = bodyAttributes
        self.footerAttributes = footerAttributes
    }

    public var body: HTML {
        Div {
            IF(header != nil) {
                Div {
                    header ?? ""
                }
                .class("card-header")
                .add(attributes: headerAttributes)
            }
            Div { content }
                .class("card-body")
                .add(attributes: bodyAttributes)
            IF(footer != nil) {
                Div {
                    footer ?? ""
                }
                .class("card-footer")
                .add(attributes: footerAttributes)
            }
        }
        .class("card")
        .add(attributes: attributes)
    }

    public func image(_ image: Img) -> Card {
        Card(header: header, content: content, footer: footer, attributes: attributes, headerAttributes: headerAttributes, bodyAttributes: bodyAttributes, footerAttributes: footerAttributes)
    }

    public func footer(@HTMLBuilder body subBody: () -> HTML) -> Card {
        Card(header: header, content: content, footer: subBody(), attributes: attributes, headerAttributes: headerAttributes, bodyAttributes: bodyAttributes, footerAttributes: footerAttributes)
    }

    public func header(@HTMLBuilder body subBody: () -> HTML) -> Card {
        Card(header: subBody(), content: content, footer: footer, attributes: attributes, headerAttributes: headerAttributes, bodyAttributes: bodyAttributes, footerAttributes: footerAttributes)
    }

    public func modifyHeader(_ modification: (Div) -> Div) -> Card {
        .init(
            header: header,
            content: content,
            footer: footer,
            attributes: attributes,
            headerAttributes: headerAttributes.add(attributes: modification(Div()).attributes),
            bodyAttributes: bodyAttributes,
            footerAttributes: footerAttributes
        )
    }

    public func modifyBody(_ modification: (Div) -> Div) -> Card {
        .init(
            header: header,
            content: content,
            footer: footer,
            attributes: attributes,
            headerAttributes: headerAttributes,
            bodyAttributes: bodyAttributes.add(attributes: modification(Div()).attributes),
            footerAttributes: footerAttributes
        )
    }

    public func modifyFooter(_ modification: (Div) -> Div) -> Card {
        .init(
            header: header,
            content: content,
            footer: footer,
            attributes: attributes,
            headerAttributes: headerAttributes,
            bodyAttributes: bodyAttributes,
            footerAttributes: footerAttributes.add(attributes: modification(Div()).attributes)
        )
    }
}

extension Card: AttributeNode {

    public func modify(if condition: Conditionable, modifyer: (Card) -> Card) -> Card {
        let emptyNode = Card(
            header: nil,
            content: Div(),
            footer: nil,
            attributes: [],
            headerAttributes: [],
            bodyAttributes: [],
            footerAttributes: []
        )
        let modified = modifyer(emptyNode)

        return Card(
            header: header,
            content: content,
            footer: footer,
            attributes: attributes.add(attributes: modified.attributes.wrapAttributes(with: condition)),
            headerAttributes: headerAttributes.add(attributes: modified.headerAttributes.wrapAttributes(with: condition)),
            bodyAttributes: bodyAttributes.add(attributes: modified.bodyAttributes.wrapAttributes(with: condition)),
            footerAttributes: footerAttributes.add(attributes: modified.footerAttributes.wrapAttributes(with: condition))
        )
    }

    public func copy(with attributes: [HTMLAttribute]) -> Card {
        .init(header: header, content: content, footer: footer, attributes: attributes, headerAttributes: headerAttributes, bodyAttributes: bodyAttributes, footerAttributes: footerAttributes)
    }
}
