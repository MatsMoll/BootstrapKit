//
//  ListGroup.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 14/09/2019.
//

import HTMLKit

public struct ListGroup<B>: HTMLComponent {

    public enum Style: String {
        case flush = "list-group list-group-flush"
        case horizontal = "list-group list-group-horizontal"
        case regular = "list-group"
    }

    let list: TemplateValue<[B]>
    let isActive: (TemplateValue<B>) -> Conditionable
    let content: (TemplateValue<B>) -> HTML

    let style: Style


    public init(_ list: TemplateValue<[B]>, isActive: @escaping (TemplateValue<B>) -> Conditionable, style: Style = .regular, content: @escaping (TemplateValue<B>) -> HTML) {
        self.list = list
        self.content = content
        self.isActive = isActive
        self.style = style
    }

    public init(_ list: TemplateValue<[B]>, style: Style = .regular, content: @escaping (TemplateValue<B>) -> HTML) {
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
