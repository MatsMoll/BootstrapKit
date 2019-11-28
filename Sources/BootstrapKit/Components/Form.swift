//
//  Form.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 17/07/2019.
//

import HTMLKit

public protocol FormInput : AddableAttributeNode {}
protocol NameableFormInput: FormInput {}

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

public struct FormRow : HTMLComponent, AttributeNode {

    public var attributes: [HTMLAttribute]
    let content: HTML

    public init(@HTMLBuilder content: () -> HTML) {
        self.content = content()
        self.attributes = []
    }

    init(attributes: [HTMLAttribute], content: HTML) {
        self.attributes = attributes
        self.content = content
    }

    public var body: HTML {
        Div { content }
            .class("form-row")
            .add(attributes: attributes)
    }

    public func copy(with attributes: [HTMLAttribute]) -> FormRow {
        .init(attributes: attributes, content: content)
    }
}

public struct FormGroup: HTMLComponent {

    public var attributes: [HTMLAttribute] = []
    let label: Label
    let input: FormInput
    let optionalContent: HTML?

    public init(_ label: Label, _ input: FormInput, @HTMLBuilder optionalContent: () -> HTML) {
        self.label = label
        self.input = input
        self.optionalContent = optionalContent()
    }

    public init(_ label: Label, _ input: FormInput) {
        self.label = label
        self.input = input
        self.optionalContent = nil
    }

    public init(label: HTML, _ input: FormInput, @HTMLBuilder optionalContent: () -> HTML) {
        self.label = Label { label }
        self.input = input
        self.optionalContent = optionalContent()
    }

    public init(label: HTML, _ input: FormInput) {
        self.label = Label { label }
        self.input = input
        self.optionalContent = nil
    }

    public init(label: HTML, @FormInputBuilder input: () -> FormInput) {
        self.label = Label { label }
        self.input = input()
        self.optionalContent = nil
    }

    public init(label: HTML, @FormInputBuilder input: () -> FormInput, @HTMLBuilder optionalContent: () -> HTML) {
        self.label = Label { label }
        self.input = input()
        self.optionalContent = optionalContent()
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
        if input.value(of: "name") == nil,
            let namable = input as? NameableFormInput {
            inputNode = namable.add(.init(attribute: "name", value: inputId), withSpace: false)
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
    public func copy(with attributes: [HTMLAttribute]) -> FormGroup {
        .init(label: label, input: input, optionalContent: optionalContent, attributes: attributes)
    }
}


public protocol InputGroupAddons : HTML {}

public struct InputGroup : HTMLComponent, AttributeNode {

    let prepend: InputGroupAddons?
    let append: InputGroupAddons?
    let invalidFeedback: HTML?
    let validFeedback: HTML?
    let input: AddableAttributeNode
    let wrapInput: Bool
    public let attributes: [HTMLAttribute]

    public init(wrapInput: Bool = true, input: () -> AddableAttributeNode) {
        self.wrapInput = wrapInput
        self.input = input()
        self.invalidFeedback = nil
        self.validFeedback = nil
        self.prepend = nil
        self.append = nil
        self.attributes = []
    }

    init(wrapInput: Bool, input: AddableAttributeNode, prepend: InputGroupAddons?, append: InputGroupAddons?, invalidFeedback: HTML?, validFeedback: HTML?, attributes: [HTMLAttribute]) {
        self.wrapInput = wrapInput
        self.input = input
        self.invalidFeedback = invalidFeedback
        self.validFeedback = validFeedback
        self.prepend = prepend
        self.append = append
        self.attributes = attributes
    }

    public var body: HTML {
        Div {
            IF(prepend != nil) {
                Div {
                    prepend ?? None() // Workaround for concrearte type
                }.class("input-group-prepend")
            }

            input.class("form-control")

            IF(append != nil) {
                Div {
                    append ?? None()
                }.class("input-group-append")
            }
            IF(invalidFeedback != nil) {
                Div {
                    invalidFeedback ?? ""
                }.class("invalid-feedback")
            }
            IF(validFeedback != nil) {
                Div {
                    validFeedback ?? ""
                }.class("valid-feedback")
            }
        }
        .class("input-group" + IF(wrapInput == false) { " flex-nowrap" })
        .add(attributes: attributes)
    }

    public func invalidFeedback(@HTMLBuilder _ feedback: () -> HTML) -> InputGroup {
        InputGroup(wrapInput: wrapInput, input: input, prepend: prepend, append: append, invalidFeedback: feedback(), validFeedback: validFeedback, attributes: attributes)
    }

    public func validFeedback(@HTMLBuilder _ feedback: () -> HTML) -> InputGroup {
        InputGroup(wrapInput: wrapInput, input: input, prepend: prepend, append: append, invalidFeedback: invalidFeedback, validFeedback: feedback(), attributes: attributes)
    }

    public func copy(with attributes: [HTMLAttribute]) -> InputGroup {
        InputGroup(wrapInput: wrapInput, input: input, prepend: prepend, append: append, invalidFeedback: invalidFeedback, validFeedback: validFeedback, attributes: attributes)
    }


    struct None: HTMLComponent {
        var body: HTML { "" }
    }

    public struct Text: HTMLComponent {

        let text: String

        public init(_ text: String) {
            self.text = text
        }

        public var body: HTML {
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
