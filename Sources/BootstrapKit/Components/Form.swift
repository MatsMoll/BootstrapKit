//
//  Form.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 17/07/2019.
//

import HTMLKit

public protocol FormInput : AttributeNode {}

extension Input : FormInput {}
extension Select : FormInput {}
extension TextArea : FormInput {}

public struct FormGroup : StaticView {

    let label: Label
    let input: FormInput
    let optionalContent: View?

    public init(_ label: Label, _ input: FormInput, @HTMLBuilder optionalContent: () -> View) {
        self.label = label
        self.input = input
        self.optionalContent = optionalContent()
    }

    public init(_ label: Label, _ input: FormInput) {
        self.label = label
        self.input = input
        self.optionalContent = nil
    }

    public init(label: View, _ input: FormInput, @HTMLBuilder optionalContent: () -> View) {
        self.label = Label { label }
        self.input = input
        self.optionalContent = optionalContent()
    }

    public init(label: View, _ input: FormInput) {
        self.label = Label { label }
        self.input = input
        self.optionalContent = nil
    }

    public var body: View {
        guard let inputId = input.id else {
            fatalError("Missing an id attribute on an Input in a FormGroup")
        }
        return Div {
            label.for(inputId)
            input.class("form-control")
            IF(optionalContent != nil) {
                optionalContent ?? ""
            }
        }.class("form-group")
    }
}

extension AttributeNode {
    var id: View? { attributes.first(where: { $0.attribute == "id" })?.value }
}
