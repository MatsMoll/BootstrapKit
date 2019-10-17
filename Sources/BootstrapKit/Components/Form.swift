//
//  Form.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 17/07/2019.
//

import HTMLKit

public protocol FormInput : AddableAttributeNode {}
protocol NamaableFormInput: FormInput, NameableAttribute {}

extension Input: FormInput {}
extension Select: FormInput {}
extension TextArea: FormInput {}
extension Div: FormInput {}

@_functionBuilder
public class FormInputBuilder {
    public static func buildBlock(_ children: FormInput...) -> FormInput {
        return children.first ?? TextArea()
    }
}

public struct FormRow : StaticView, AttributeNode {

    public var attributes: [HTML.Attribute]
    let content: View

    public init(@HTMLBuilder content: () -> View) {
        self.content = content()
        self.attributes = []
    }

    init(attributes: [HTML.Attribute], content: View) {
        self.attributes = attributes
        self.content = content
    }

    public var body: View {
        Div { content }
            .class("form-row")
            .add(attributes: attributes)
    }

    public func copy(with attributes: [HTML.Attribute]) -> FormRow {
        .init(attributes: attributes, content: content)
    }
}

public struct FormGroup: StaticView {

    public var attributes: [HTML.Attribute] = []
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

    public init(label: View, @FormInputBuilder input: () -> FormInput) {
        self.label = Label { label }
        self.input = input()
        self.optionalContent = nil
    }

    public init(label: View, @FormInputBuilder input: () -> FormInput, @HTMLBuilder optionalContent: () -> View) {
        self.label = Label { label }
        self.input = input()
        self.optionalContent = optionalContent()
    }

    init(label: Label, input: FormInput, optionalContent: View?, attributes: [HTML.Attribute]) {
        self.label = label
        self.input = input
        self.optionalContent = optionalContent
        self.attributes = attributes
    }

    public var body: View {
        guard let inputId = input.value(of: "id") else {
            fatalError("Missing an id attribute on an Input in a FormGroup")
        }
        var inputNode = input
        if input.value(of: "name") == nil,
            let namable = input as? NamaableFormInput {
            inputNode = namable.name(inputId)
        }
        return Div {
            label.for(inputId)
            inputNode.class("form-control")
            IF(optionalContent != nil) {
                optionalContent ?? ""
            }
        }
        .class("form-group")
        .add(attributes: attributes)
    }
}

extension FormGroup: AttributeNode {
    public func copy(with attributes: [HTML.Attribute]) -> FormGroup {
        .init(label: label, input: input, optionalContent: optionalContent, attributes: attributes)
    }
}


public protocol InputGroupAddons : View {}

public struct InputGroup : StaticView {

    let prepend: InputGroupAddons?
    let append: InputGroupAddons?
    let input: Input
    let wrapInput: Bool

    public var body: View {
        Div {
            IF(prepend != nil) {
                Div {
                    prepend ?? None() // Workaround for concrearte type
                }.class("input-group-prepend")
            }

            input.class("form-controll")

            IF(append != nil) {
                Div {
                    append ?? None()
                }.class("input-group-append")
            }
        }
            .class("input-group" + IF(wrapInput == false) { " flex-nowrap" })
    }


    struct None: StaticView {
        var body: View { "" }
    }

    public struct Text: StaticView {

        let text: String

        public init(_ text: String) {
            self.text = text
        }

        public var body: View {
            Span {
                text
            }.class("input-group-text")
        }
    }

    typealias ButtonAddon = Button
    typealias DropdownAddon = Dropdown
}

extension InputGroup.None : InputGroupAddons {}
extension InputGroup.Text : InputGroupAddons {}
extension InputGroup.ButtonAddon : InputGroupAddons {}
extension InputGroup.DropdownAddon : InputGroupAddons {}
