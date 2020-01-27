//
//  BootstrapViews.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 13/07/2019.
//

import BootstrapKit
import HTMLKit

struct TextView : HTMLComponent {
    
    var body: HTML {
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

struct ColumnView : HTMLComponent {
    
    var body: HTML {
        Container {
            Text { "Hello World!" }
        }
            .columnWidth(3, for: .small)
            .columnWidth(6, for: .medium)
            .columnWidth(12)
            .text(alignment: .left)
    }
}

struct AlertViewTest : HTMLComponent {
    
    var body: HTML {
        Container(mode: .fluid) {
            Alert {
                "This is an importante message 1"
            }
                .isDismissable(false)
                .background(color: .dark)
            
            Alert {
                "This is an importante message 2"
            }
                .isDismissable(true)
                .background(color: .success)
            
            Alert {
                "This is an importante message 3"
            }
        }
    }
}

struct BreadcrumbViewTest : HTMLTemplate {
    
    var context: TemplateValue<String> = .root()
    
    var body: HTML {
        Breadcrumb {
            BreadcrumbItem(uri: "#", title: "Title 1")
            BreadcrumbItem(uri: "#", title: "Title 2", isActive: context.isEmpty == false)
        }
    }
}

struct CardViewTest : HTMLComponent {

    var body: HTML {
        Container {
            Card {
                Text(style: .cardTitle) { "Hello!" }
                Text(style: .cardText) { "Some text" }
            }
            Card {
                Img(source: "#")
                Text(style: .cardTitle) { "Hello!" }
                Text(style: .cardText) { "Some text" }
            }
        }
    }
}


struct AccordionViewTest : HTMLTemplate {

    let context: TemplateValue<[Subscription]> = .root()

    var body: HTML {
        Container {
            ForEach(in: context) { sub in
                sub.description.unsafelyUnwrapped.count
                sub.price
            }
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
struct LoginContext {
    let loginError: String?
    let options: [String]
}

struct Subscription : Equatable {
    let description: String?
    let price: Int
}

struct FormViewTest : HTMLTemplate {

    let context: TemplateValue<LoginContext> = .root()

    var body: HTML {
        Container {
            IF(context.loginError.isDefined) {
                Alert {
                    context.loginError
                }
                .isDismissable(true)
                .background(color: .danger)
                .margin(.three, for: .bottom)
            }
            Form {
                FormGroup(label: "Username") {
                    Input(type: .text, id: "username")
                }
                FormGroup(
                    label: "Password",
                    Input(type: .password, id: "password")) {
                        Small { "Needs to contain ..." }
                }
                FormGroup(label: "Test") {
                    Select(context.options) { option in
                        Text { option }
                            .style(.heading5)
                    }
                    .id("test")
                }
            }
        }
    }
}

struct InputGroupTest: HTMLTemplate {
    let context: TemplateValue<LoginContext> = .root()

    var body: HTML {
        Container {
            Form {
                InputGroup {
                    Input(type: .text, id: "username")
                        .placeholder("Name")
                        .name("username")
                }
                .prepend {
                    InputGroup.Text("User")
                }
                .append {
                    Button {
                        "Create"
                    }
                    .button(style: .success)
                    .name("submit")
                }
            }
        }
    }
}

struct ListGroupTest: HTMLTemplate {

    @TemplateValue([Subscription].self)
    var context

    var body: HTML {
        Div {
            ListGroup(context) { value in
                Text {
                    value.description
                }
            }
            ListGroup(context) { value in
                Text {
                    value.price + " " + value.description
                }
            }.isActive {
                $0.price < 100
            }
        }
    }
}

struct RootView: HTMLComponent {

    var body: HTML {
        NavigationBar {
            NavigationBar.Brand(link: "#") {
                "Test"
            }
            NavigationBar.Collapse {
                ""
            }
        }
        .expandOn(.medium)
    }
}

