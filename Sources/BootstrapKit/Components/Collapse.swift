//
//  Collapse.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 15/07/2019.
//

import HTMLKit
import Foundation

public protocol Collapsable {
    func collapse(_ identifier: HTMLIdentifier) -> Self
}

extension Collapsable where Self: AttributeNode {
    public func collapse(_ identifier: HTMLIdentifier) -> Self {
        self.data(for: "toggle", value: "collapse")
            .add(.init(attribute: "href", value: identifier))
    }
}

extension GlobalAttributes {
    public var isCollapsed: Self {
        self.class("collapse")
    }
}

extension Button : Collapsable {}


@_functionBuilder
public class AccordionBuilder {

    public static func buildBlock(_ children: Accordion.Group...) -> [Accordion.Group] {
        return children
    }
}

public struct Accordion : HTMLComponent {

    public struct Head : HTMLComponent {

        let id: String
        let title: HTML
        let colapseIdentifier: HTMLIdentifier

        public var body: HTML {
            Div {
                Text(style: .heading2) {
                    Button {
                        title
                    }.collapse(colapseIdentifier)
                }
            }
                .class("card-header")
                .id(id)
        }
    }

    public struct Body : HTMLComponent {

        let id: HTML
        let content: HTML
        let dataParent: HTMLIdentifier
        public var attributes: [HTMLAttribute]

        public var body: HTML {
            Div {
                Div {
                    content
                }.class("card-body")
            }
                .isCollapsed
                .id(id)
                .data(for: "parent", value: dataParent)
                .add(attributes: attributes)
        }
    }

    public struct Group : HTMLComponent {

        let head: Head
        let content: Body
        public var attributes: [HTMLAttribute]

        public init(title: HTML, @HTMLBuilder content: () -> HTML) {
            let headId = UUID().uuidString
            let bodyId = UUID().uuidString
            self.head = Head(id: headId, title: title, colapseIdentifier: .id(bodyId))
            self.content = Body(id: bodyId, content: content(), dataParent: .id(""), attributes: [])
                .aria(for: "labelledby", value: headId)
            self.attributes = []
        }

        init(head: Head, content: Body, attributes: [HTMLAttribute]) {
            self.head = head
            self.content = content
            self.attributes = attributes
        }

        public var body: HTML {
            Div {
                head
                content
            }.class("card")
        }
    }


    let id: String

    let content: HTML

    public var attributes: [HTMLAttribute]

    public init(id: String = UUID().uuidString, @AccordionBuilder content: () -> [Accordion.Group]) {
        self.id = id
        self.content = content().map { $0.dataParent(.id(id)) }
        self.attributes = []
    }

    init(id: String, content: HTML, attributes: [HTMLAttribute]) {
        self.id = id
        self.content = content
        self.attributes = attributes
    }

    public var body: HTML {
        Div {
            content
        }
            .id(id)
            .class("accordion")
    }
}

extension Accordion.Body : AttributeNode, GlobalAttributes {

    public func copy(with attributes: [HTMLAttribute]) -> Accordion.Body {
        .init(id: id, content: content, dataParent: dataParent, attributes: attributes)
    }

    public func dataParent(_ identifier: HTMLIdentifier) -> Accordion.Body {
        .init(id: id, content: content, dataParent: identifier, attributes: attributes)
    }
}

extension Accordion.Group : AttributeNode, GlobalAttributes {

    public func copy(with attributes: [HTMLAttribute]) -> Accordion.Group {
        .init(head: head, content: content, attributes: attributes)
    }

    public func dataParent(_ identifier: HTMLIdentifier) -> Accordion.Group {
        .init(head: head, content: content.dataParent(identifier), attributes: attributes)
    }
}


extension Accordion : AttributeNode {

    public func copy(with attributes: [HTMLAttribute]) -> Accordion {
        .init(id: id, content: content, attributes: attributes)
    }

    public func id(_ value: HTML) -> Accordion {
        guard let stringValue = value as? String else {
            fatalError("Accordion needs a id of type String")
        }
        return .init(id: stringValue, content: content, attributes: attributes)
    }
}
