//
//  Text.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 14/07/2019.
//

import HTMLKit


public struct Text : StaticView, AttributeNode {
    
    public enum Style : String {
        case display1 = "display-1"
        case display2 = "display-2"
        case display3 = "display-3"
        case display4 = "display-4"
        
        case heading1 = "h1"
        case heading2 = "h2"
        case heading3 = "h3"
        case heading4 = "h4"
        case heading5 = "h5"
        case heading6 = "h6"
        
        case lead
        
        case paragraph = "p"
        
        case blockquote

        case cardTitle = "card-title"
        case cardSubtitle = "card-subtitle"
        case cardText = "card-text"
    }
    
    public enum Alignment : String {
        case left
        case right
        case center
    }
    
    let style: Style
    public var attributes: [HTML.Attribute]
    let content: View
    
    public init(style: Style = .paragraph, @HTMLBuilder content: () -> View) {
        self.style = style
        self.content = content()
        self.attributes = []
    }
    
    init(style: Style, attributes: [HTML.Attribute], content: View) {
        self.style = style
        self.attributes = attributes
        self.content = content
    }
    
    public var body: View {
        switch style {
        case .display1, .display2, .display3, .display4:
            return H1 { content }.class(style.rawValue)
        case .heading1:
            return H1 { content }
        case .heading2:
            return H2 { content }
        case .heading3:
            return H3 { content }
        case .heading4:
            return H4 { content }
        case .heading5:
            return H5 { content }
        case .heading6:
            return H6 { content }
        case .blockquote:
            return Blockquote { content }.class(style.rawValue)
        case .lead, .cardText:
            return P { content }.class(style.rawValue)
        case .paragraph:
            return P { content }
        case .cardTitle:
            return H5 { content }.class(style.rawValue)
        case .cardSubtitle:
            return H6 { content }.class(style.rawValue)
        }
    }
    
    public func copy(with attributes: [HTML.Attribute]) -> Text {
        .init(style: style, attributes: attributes, content: content)
    }
}
