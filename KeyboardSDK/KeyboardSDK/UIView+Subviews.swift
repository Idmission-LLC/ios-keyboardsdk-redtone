//
//  UIView+Subviews.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView {
    
    /**
     Add a subview with an option to adjust its anchords to
     make it fill its superview.
     */
    func addSubview(_ subview: UIView, fill: Bool) {
        addSubview(subview)
        guard fill else { return }
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func addCenterSubview(_ subview: UIView, fill: Bool, padding: CGFloat) {
        addSubview(subview)
        guard fill else { return }
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        subview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
    }

    func addTwoSubview(subview1: UIView, subview2: UIView, firstViewWidth_Multiplier:CGFloat, firstViewLeft_Padding: CGFloat) {
        addSubview(subview1)
        addSubview(subview2)
        subview1.translatesAutoresizingMaskIntoConstraints = false
        subview2.translatesAutoresizingMaskIntoConstraints = false

        subview1.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        subview1.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        subview1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: firstViewLeft_Padding).isActive = true
        subview1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: firstViewWidth_Multiplier).isActive = true

        subview2.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        subview2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        subview2.leadingAnchor.constraint(equalTo: subview1.trailingAnchor, constant: 5).isActive = true
        subview2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
    }

    func addThreeSubview(subview1: UIView, subview2: UIView, subview3: UIView) {
        addSubview(subview1)
        addSubview(subview2)
        addSubview(subview3)
        subview1.translatesAutoresizingMaskIntoConstraints = false
        subview2.translatesAutoresizingMaskIntoConstraints = false
        subview3.translatesAutoresizingMaskIntoConstraints = false

        subview1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        subview1.trailingAnchor.constraint(equalTo: subview2.leadingAnchor, constant: -5).isActive = true
        subview1.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        subview1.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true

        subview2.trailingAnchor.constraint(equalTo: subview3.leadingAnchor, constant: -5).isActive = true
        subview2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.16665).isActive = true
        subview2.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        subview2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true

        subview3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        subview3.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.16665).isActive = true
        subview3.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        subview3.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }

    func addSubviewForHeader(subview1: UIView, subview2: UIView, subview3: UIView, singleViewWidth:CGFloat) {
        addSubview(subview1)
        addSubview(subview2)
        addSubview(subview3)
        subview1.translatesAutoresizingMaskIntoConstraints = false
        subview2.translatesAutoresizingMaskIntoConstraints = false
        subview3.translatesAutoresizingMaskIntoConstraints = false

        subview1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        subview1.widthAnchor.constraint(equalToConstant: singleViewWidth).isActive = true
        subview1.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        subview1.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        subview2.leadingAnchor.constraint(equalTo: subview1.trailingAnchor, constant: 10).isActive = true
        subview2.widthAnchor.constraint(equalToConstant: singleViewWidth).isActive = true
        subview2.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        subview2.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        subview3.leadingAnchor.constraint(equalTo: subview2.trailingAnchor, constant: 10).isActive = true
//        subview3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -leadingConstant).isActive = true
        subview3.widthAnchor.constraint(equalToConstant: singleViewWidth).isActive = true
        subview3.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        subview3.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }

    /**
     Add a trailing subview with a certain width.
     */
    func addTrailingSubview(_ subview: UIView, width: CGFloat, height: CGFloat? = nil) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        subview.widthAnchor.constraint(equalToConstant: width).isActive = true
        if let height = height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        } else {
            subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
            subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
}
