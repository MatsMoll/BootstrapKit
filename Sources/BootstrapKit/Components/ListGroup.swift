//
//  ListGroup.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 14/09/2019.
//

import HTMLKit

public struct ListGroup<A, B>: HTMLComponent {

    public enum Style: String {
        case flush = "list-group list-group-flush"
        case horizontal = "list-group list-group-horizontal"
        case regular = "list-group"
    }

    let list: TemplateValue<A, [B]>
    let isActive: (TemplateValue<B, B>) -> Conditionable
    let content: (TemplateValue<B, B>) -> HTML

    let style: Style


    public init(_ list: TemplateValue<A, [B]>, isActive: @escaping (TemplateValue<B, B>) -> Conditionable, style: Style = .regular, content: @escaping (TemplateValue<B, B>) -> HTML) {
        self.list = list
        self.content = content
        self.isActive = isActive
        self.style = style
    }

    public init(_ list: TemplateValue<A, [B]>, style: Style = .regular, content: @escaping (TemplateValue<B, B>) -> HTML) {
        self.list = list
        self.content = content
        self.isActive = { _ in false }
        self.style = style
    }

    public var body: HTML {
        UnorderdList {
            ForEach(in: list) { value in
                ListItem {
                    content(value)
                }
                .class("list-group-item" + IF(isActive(value)) { " active" })
            }
        }.class(style.rawValue)
    }
}
