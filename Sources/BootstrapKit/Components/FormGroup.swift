
public struct FormGroup: HTMLComponent {

    public var attributes: [HTMLAttribute] = []
    let label: Label
    let input: FormInput
    let optionalContent: HTML?

    public init(label: HTML, input: () -> FormInput) {
        self.label = Label { label }
        self.input = input()
        self.optionalContent = nil
    }

    init(label: Label, input: FormInput, optionalContent: HTML?, attributes: [HTMLAttribute]) {
        self.label = label
        self.input = input
        self.optionalContent = optionalContent
        self.attributes = attributes
    }

    public var body: HTML {
        guard let inputId = input.value(of: "id") else {
            fatalError("Missing an id attribute on an Input in a FormGroup")
        }
        var inputNode = input
        if input.value(of: "name") == nil {
            inputNode = input.add(.init(attribute: "name", value: inputId), withSpace: false)
        }
        return Div {
            label.for(inputId)
            inputNode.class("form-control")
            IF(optionalContent != nil) {
                Small {
                    optionalContent ?? ""
                }
            }
        }
        .class("form-group")
        .add(attributes: attributes)
    }


    public func description(@HTMLBuilder content: () -> HTML) -> FormGroup {
        .init(label: label, input: input, optionalContent: content(), attributes: attributes)
    }
}

extension FormGroup: AttributeNode {
    public func copy(with attributes: [HTMLAttribute]) -> FormGroup {
        .init(label: label, input: input, optionalContent: optionalContent, attributes: attributes)
    }
}
