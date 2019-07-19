//
//  Form.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 17/07/2019.
//

import HTMLKit

public struct FormGroup : StaticView {

    let label: Label
    let input: Input
    let optionalContent: View?

    public init(_ label: Label, _ input: Input, @HTMLBuilder optionalContent: () -> View) {
        self.label = label
        self.input = input
        self.optionalContent = optionalContent()
    }

    public init(_ label: Label, _ input: Input) {
        self.label = label
        self.input = input
        self.optionalContent = nil
    }

    public init(label: View, _ input: Input, @HTMLBuilder optionalContent: () -> View) {
        self.label = Label { label }
        self.input = input
        self.optionalContent = optionalContent()
    }

    public init(label: View, _ input: Input) {
        self.label = Label { label }
        self.input = input
        self.optionalContent = nil
    }

    public var body: View {
        return Div {
            label.for(input.id!)
            input
            IF(.constant(optionalContent != nil)) {
                optionalContent ?? ""
            }
        }.class("form-group")
    }
}

extension AttributeNode {
    var id: View? { attributes.first(where: { $0.attribute == "id" })?.value }
}
