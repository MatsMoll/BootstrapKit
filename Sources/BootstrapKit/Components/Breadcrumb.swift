//
//  Breadcrumb.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 14/07/2019.
//

import HTMLKit

public struct Breadcrumb: HTMLComponent, AttributeNode {
    
    let breadcrumbItems: HTML
    public var attributes: [HTMLAttribute] = []

    init(breadcrumbItems: HTML, attributes: [HTMLAttribute]) {
        self.breadcrumbItems = breadcrumbItems
        self.attributes = attributes
    }

    public init(@HTMLBuilder breadcrumbItems: () -> HTML) {
        self.breadcrumbItems = breadcrumbItems()
    }

    public init<B>(items: TemplateValue<[B]>, isActive: (TemplateValue<B>) -> Conditionable, @HTMLBuilder content: (TemplateValue<B>) -> HTML) {
        self.breadcrumbItems = ForEach(in: items) { item in
            ListItem {
                content(item)
            }
            .class("breadcrumb-item")
            .modify(if: isActive(item)) { (view: ListItem) in
                view.class("active")
                    .aria(for: "current", value: "page")
            }
        }
    }
    
    public var body: HTML {
        Nav {
            OrderedList {
                breadcrumbItems
            }
            .class("breadcrumb")
        }
        .aria(for: "label", value: "breadcrumb")
        .add(attributes: attributes)
    }

    public func copy(with attributes: [HTMLAttribute]) -> Breadcrumb {
        .init(breadcrumbItems: breadcrumbItems, attributes: attributes)
    }
}

extension Breadcrumb {
    public init<A>(items: [A], isActive: (TemplateValue<A>) -> Conditionable, @HTMLBuilder content: (TemplateValue<A>) -> HTML) {
        self.init(items: TemplateValue<[A]>.constant(items), isActive: isActive, content: content)
    }
}

public struct BreadcrumbItem : HTMLComponent {
    
    let uri: HTML
    let title: HTML
    let isActive: Conditionable
    
    public init(uri: HTML, title: HTML, isActive: Conditionable = false) {
        self.uri = uri
        self.title = title
        self.isActive = isActive
    }
    
    public var body: HTML {
        ListItem {
            Anchor { title }.href(uri)
        }
            .class("breadcrumb-item" + IF(isActive) { " active" })
    }
}
