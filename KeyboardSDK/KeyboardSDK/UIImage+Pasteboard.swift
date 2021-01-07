//
//  UIColor+Copy.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /**
     Copies the image to the system pasteboard, using png as
     file format.
     */
    func copyToPasteboard(_ pasteboard: UIPasteboard = .general) -> Bool {
        guard let data = pngData() else { return false }
        pasteboard.setData(data, forPasteboardType: "public.png")
        return true
    }
}

public extension UIImage {
    static func setImageFromBundle(name: String) -> UIImage? {
    let bundle = Bundle(for: DemoButton.self)
        if #available(iOS 13.0, *) {
            return UIImage(named: name, in: bundle, with: .none)
        } else {
            // Fallback on earlier versions
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
  }
}
