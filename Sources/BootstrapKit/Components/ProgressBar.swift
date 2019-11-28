//
//  ProgressBar.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 17/07/2019.
//

import HTMLKit

public struct ProgressBar<A, B>: HTMLComponent, AttributeNode where B: Comparable, B: HTML {

    public var attributes: [HTMLAttribute] = []
    let maxValue: B
    let minValue: B
    let currentValue: TemplateValue<A, B>
    var barDiv: Div = Div()

    public init(currentValue: TemplateValue<A, B>, valueRange: Range<B>) {
        self.currentValue = currentValue
        self.maxValue = valueRange.upperBound
        self.minValue = valueRange.lowerBound
    }

    public init(currentValue: TemplateValue<A, B>, valueRange: ClosedRange<B>) {
        self.currentValue = currentValue
        self.maxValue = valueRange.upperBound
        self.minValue = valueRange.lowerBound
    }

    init(currentValue: TemplateValue<A, B>, minValue: B, maxValue: B, barDiv: Div, attributes: [HTMLAttribute]) {
        self.currentValue = currentValue
        self.maxValue = maxValue
        self.minValue = minValue
        self.barDiv = barDiv
        self.attributes = attributes
    }

    public var body: HTML {
        Div {
            barDiv
                .class("progress-bar")
                .role("progressbar")
                .aria(for: "valuemax", value: maxValue)
                .aria(for: "valuemin", value: minValue)
                .aria(for: "valuenow", value: currentValue)
                .style(css: "width: " + currentValue + "%;")
        }
        .class("progress")
        .add(attributes: attributes)
    }

    public func bar(size: SizeClass) -> ProgressBar {
        self.class("progress-\(size.rawValue)")
    }

    public func bar(style: BootstrapStyle) -> ProgressBar {
        return .init(
            currentValue: currentValue,
            minValue: minValue,
            maxValue: maxValue,
            barDiv: barDiv.background(color: style),
            attributes: attributes
        )
    }

    public func bar(id: HTML) -> ProgressBar {
        return .init(
            currentValue: currentValue,
            minValue: minValue,
            maxValue: maxValue,
            barDiv: barDiv.id(id),
            attributes: attributes
        )
    }

    public func copy(with attributes: [HTMLAttribute]) -> ProgressBar<A, B> {
        return .init(currentValue: currentValue, minValue: minValue, maxValue: maxValue, barDiv: barDiv, attributes: attributes)
    }

    public func modify(if condition: Conditionable, modifyer: (ProgressBar<A, B>) -> ProgressBar<A, B>) -> ProgressBar<A, B> {
        let emptyNode = ProgressBar(currentValue: currentValue, minValue: minValue, maxValue: maxValue, barDiv: barDiv.copy(with: []), attributes: [])
        let modified = modifyer(emptyNode)
        let modifiedBar = modified.barDiv.wrapAttributes(with: condition)
        let modifiedAttributes = modified.wrapAttributes(with: condition)
        return ProgressBar(
            currentValue: currentValue,
            minValue: minValue,
            maxValue: maxValue,
            barDiv: barDiv.add(attributes: modifiedBar),
            attributes: attributes
        )
            .add(attributes: modifiedAttributes)
    }
}
