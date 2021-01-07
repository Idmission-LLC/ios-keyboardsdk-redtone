//
//  HeaderToolbar.swift
//  KeyboardSDK
//
//  Created by MCB-Air-036 on 05/06/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import Foundation
import UIKit

public class HeaderToolbar: KeyboardToolbar {


    // MARK: - Initialization

    /**
     Create an autocomplete toolbar that has a custom button
     creation function.
     */
    public init(
        height: CGFloat = 100,
        buttonCreator: @escaping ButtonCreator,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually) {
        self.buttonCreator = buttonCreator
        super.init(height: height, alignment: alignment, distribution: distribution)
        stackView.spacing = 0
    }

    /**
     Create an autocomplete toolbar that uses standard label
     classes of type `AutocompleteToolbarLabel` to provide a
     way to send suggestions to a `UITextDocumentProxy`.
     */
    public convenience init(
        height: CGFloat = 50,
        textDocumentProxy: UITextDocumentProxy,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually) {
        self.init(
            height: 50,
            buttonCreator: { HeaderToolbarView(text: $0, textDocumentProxy: textDocumentProxy) },
            alignment: alignment,
            distribution: distribution
        )
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Types

    public typealias ButtonCreator = (String) -> (UIView)


    // MARK: - Properties

    private let buttonCreator: ButtonCreator

    private var suggestions: [String] = [] {
        didSet {
            if oldValue == suggestions { return }
            let buttons = suggestions.map { buttonCreator($0) }
            stackView.removeAllArrangedSubviews()
            stackView.addArrangedSubviews(buttons)
        }
    }


    // MARK: - Functions

    /**
     Reset the toolbar by removing all suggestions.
     */
    public func reset() {
        update(with: [])
    }

    /**
     Update the toolbar with new words. This will remove all
     previously added views from the stack view and create a
     new set of views for the new word collection.
     */
    public func update(with suggestions: [String]) {
        self.suggestions = suggestions
    }
}
