//
//  Collapse.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 15/07/2019.
//

import HTMLKit
import Foundation

public protocol Collapsable {
    func collapse(_ identifier: HTML.Identifier) -> Self
}

extension Collapsable where Self : AttributeNode {
    public func collapse(_ identifier: HTML.Identifier) -> Self {
        self.dataToggle("collapse")
            .href(identifier)
    }
}

extension AttributeNode {
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

public struct Accordion : StaticView {

    public struct Head : StaticView {

        let id: String
        let title: View
        let colapseIdentifier: HTML.Identifier

        public var body: View {
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

    public struct Body : StaticView {

        let id: View
        let content: View
        let dataParent: HTML.Identifier
        public var attributes: [HTML.Attribute]

        public var body: View {
            Div {
                Div {
                    content
                }.class("card-body")
            }
                .isCollapsed
                .id(id)
                .dataParent(dataParent)
                .add(attributes: attributes)
        }
    }

    public struct Group : StaticView {

        let head: Head
        let content: Body
        public var attributes: [HTML.Attribute]

        public init(title: View, @HTMLBuilder content: () -> View) {
            let headId = UUID().uuidString
            let bodyId = UUID().uuidString
            self.head = Head(id: headId, title: title, colapseIdentifier: .id(bodyId))
            self.content = Body(id: bodyId, content: content(), dataParent: .id(""), attributes: [])
                .ariaLabelledBy(headId)
            self.attributes = []
        }

        init(head: Head, content: Body, attributes: [HTML.Attribute]) {
            self.head = head
            self.content = content
            self.attributes = attributes
        }

        public var body: View {
            Div {
                head
                content
            }.class("card")
        }
    }


    let id: String

    let content: View

    public var attributes: [HTML.Attribute]

    public init(id: String = UUID().uuidString, @AccordionBuilder content: () -> [Accordion.Group]) {
        self.id = id
        self.content = content().map { $0.dataParent(.id(id)) }
        self.attributes = []
    }

    init(id: String, content: View, attributes: [HTML.Attribute]) {
        self.id = id
        self.content = content
        self.attributes = attributes
    }

    public var body: View {
        Div {
            content
        }
            .id(id)
            .class("accordion")
    }
}


extension AttributeNode {

    func dataParent(_ identifier: HTML.Identifier) -> Self {
        self.add(.init(attribute: "data-parent", value: identifier))
    }
}

extension Accordion.Body : AttributeNode {

    public func copy(with attributes: [HTML.Attribute]) -> Accordion.Body {
        .init(id: id, content: content, dataParent: dataParent, attributes: attributes)
    }

    public func dataParent(_ identifier: HTML.Identifier) -> Accordion.Body {
        .init(id: id, content: content, dataParent: identifier, attributes: attributes)
    }
}

extension Accordion.Group : AttributeNode {

    public func copy(with attributes: [HTML.Attribute]) -> Accordion.Group {
        .init(head: head, content: content, attributes: attributes)
    }

    public func dataParent(_ identifier: HTML.Identifier) -> Accordion.Group {
        .init(head: head, content: content.dataParent(identifier), attributes: attributes)
    }
}


extension Accordion : AttributeNode {

    public func copy(with attributes: [HTML.Attribute]) -> Accordion {
        .init(id: id, content: content, attributes: attributes)
    }

    public func id(_ value: View) -> Accordion {
        guard let stringValue = value as? String else {
            fatalError("Accordion needs a id of type String")
        }
        return .init(id: stringValue, content: content, attributes: attributes)
    }
}
