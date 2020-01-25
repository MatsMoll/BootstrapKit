public struct Modal: HTMLComponent, AttributeNode {

    let title: HTML
    let content: HTML
    public var attributes: [HTMLAttribute]

    public init(title: HTML, id: HTML, @HTMLBuilder content: () -> HTML) {
        self.title = title
        self.content = content()
        self.attributes = [HTMLAttribute(attribute: "id", value: id)]
    }

    private init(title: HTML, content: HTML, attributes: [HTMLAttribute]) {
        self.title = title
        self.content = content
        self.attributes = attributes
    }

    public var body: HTML {
        let id = value(of: "id") ?? "modal-content"
        let modifiesAttributes = attributes.filter({ $0.attribute != "id" })
        return Div {
            Div {
                Div {
                    Div {
                        H4 {
                            title
                        }
                        .class("modal-title")

                        Button {
                            "×"
                        }
                        .type("button")
                        .class("close")
                        .data(for: "dismiss", value: "modal")
                        .aria(for: "hidden", value: "true")
                    }
                    .class("modal-header bg-light")

                    Div {
                        Div {
                            content
                        }
                        .class("p-2")
                    }
                    .class("modal-body")
                }
                .class("modal-content")
            }
            .class("modal-dialog modal-dialog-centered modal-lg")
        }
        .class("modal fade")
        .id(id)
        .role("dialog")
        .aria(for: "labelledby", value: id)
        .aria(for: "hidden", value: "true")
        .add(attributes: modifiesAttributes)
    }

    public func copy(with attributes: [HTMLAttribute]) -> Modal {
        .init(title: title, content: content, attributes: attributes)
    }
}
