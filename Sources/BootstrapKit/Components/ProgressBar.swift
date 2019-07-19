//
//  ProgressBar.swift
//  BootstrapKit
//
//  Created by Mats Mollestad on 17/07/2019.
//

import HTMLKit

public struct ProgressBar<T> : StaticView {

    let valueRange: Range<Double>
    let currentValue: TemplateValue<T, Double>

    public var body: View {
        Div {
            Div {
                ""
            }
                .class("progress-bar")
                .role("progressbar")
                .ariaValuemin(valueRange.lowerBound)
                .ariaValuemax(valueRange.upperBound)
                .ariaValuenow(currentValue)
        }.class("progress")
    }
}
