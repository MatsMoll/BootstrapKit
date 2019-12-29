//
//  ListGroup.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 14/09/2019.
//

import HTMLKit

public struct ListGroup<B>: HTMLComponent {

    public enum Style: String {
        case flush      = "list-group list-group-flush"
        case horizontal = "list-group list-group-horizontal"
        case regular    = "list-group"
    }

    let list: TemplateValue<[B]>
    let isActive: (TemplateValue<B>) -> Conditionable
    let content: (TemplateValue<B>) -> HTML

    let style: Style


    init(_ list: TemplateValue<[B]>, isActive: @escaping (TemplateValue<B>) -> Conditionable, content: @escaping (TemplateValue<B>) -> HTML, style: Style) {
        self.list = list
        self.content = content
        self.isActive = isActive
        self.style = style
    }

    public init(_ list: TemplateValue<[B]>, content: @escaping (TemplateValue<B>) -> HTML) {
        self.list = list
        self.content = content
        self.isActive = { _ in false }
        self.style = .regular
    }

    public func isActive(_ isActive: @escaping (TemplateValue<B>) -> Conditionable) -> ListGroup {
        .init(list, isActive: isActive, content: content, style: style)
    }

    public func style(_ style: Style) -> ListGroup {
        .init(list, isActive: isActive, content: content, style: style)
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
