//
//  Breadcrumb.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 14/07/2019.
//

import HTMLKit

public struct Breadcrumb : StaticView {
    
    let breadcrumbItems: View
    
    public init(@HTMLBuilder breadcrumbItems: () -> View) {
        self.breadcrumbItems = breadcrumbItems()
    }
    
    public var body: View {
        Nav {
            OrderdList {
                breadcrumbItems
            }.class("breadcrumb")
        }.aria(for: "label", value: "breadcrumb")
    }
}

public struct BreadcrumbItem : StaticView {
    
    let uri: View
    let title: View
    let isActive: Conditionable
    
    public init(uri: View, title: View, isActive: Conditionable = false) {
        self.uri = uri
        self.title = title
        self.isActive = isActive
    }
    
    public var body: View {
        ListItem {
            Anchor { title }.href(uri)
        }
            .class("breadcrumb-item" + IF(isActive) { " active" })
    }
}
