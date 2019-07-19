//
//  BootstrapViews.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 13/07/2019.
//

import BootstrapKit
import HTMLKit

struct TextView : StaticView {
    
    var body: View {
        Container {
            Text(style: .display1) { "d1" }
            Text(style: .display2) { "d2" }
            Text(style: .display3) { "d3" }
            Text(style: .display4) { "d4" }
            
            Text(style: .heading1) { "h1" }
            Text(style: .heading2) { "h2" }
            Text(style: .heading3) { "h3" }
            Text(style: .heading4) { "h4" }
            Text(style: .heading5) { "h5" }
            Text(style: .heading6) { "h6" }
            
            Text(style: .lead) { "lead" }
            
            Text(style: .blockquote) { "blockquote" }
            
            Text(style: .paragraph) { "Simple P" }
        }
    }
}

struct ColumnView : StaticView {
    
    var body: View {
        Container {
            Text { "Hello World!" }
        }
            .columnWidth(3, for: .small)
            .columnWidth(6, for: .medium)
            .columnWidth(12)
            .textAlignment(.left)
    }
}

struct AlertViewTest : StaticView {
    
    var body: View {
        Container(mode: .fluid) {
            Alert {
                "This is an importante message 1"
            }
                .isDismissable(false)
                .style(.dark)
            
            Alert {
                "This is an importante message 2"
            }
                .isDismissable(true)
                .style(.success)
            
            Alert {
                "This is an importante message 3"
            }
        }
    }
}

struct BreadcrumbViewTest : TemplateView {
    
    var context: RootValue<String> = .root()
    
    var body: View {
        Breadcrumb {
            BreadcrumbItem(uri: "#", title: "Title 1")
            BreadcrumbItem(uri: "#", title: "Title 2", isActive: context.isEmpty == false)
        }
    }
}

struct CardViewTest : StaticView {

    var body: View {
        Container {
            Card {
                Text(style: .cardTitle) { "Hello!" }
                Text(style: .cardText) { "Some text" }
            }
            Card(image: Img(source: "#")) {
                Text(style: .cardTitle) { "Hello!" }
                Text(style: .cardText) { "Some text" }
            }
        }
    }
}


struct AccordionViewTest : StaticView {

    var body: View {
        Container {
            Accordion {
                Accordion.Group(title: "Hello") {
                    Div { "Test" }
                }
                Accordion.Group(title: "Hello 2") {
                    Div { "Test 2" }
                }
            }
        }
    }
}


struct FormViewTest : StaticView {

    var body: View {
        Form {
            FormGroup(label: "Username", Input(type: .text, id: "username"))
            FormGroup(label: "Password", Input(type: .password, id: "password")) {
                Small { "Needs to contain ..." }
            }
            Spinner()
        }
    }
}
