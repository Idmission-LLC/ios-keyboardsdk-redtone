//
//  CustomAlertButton.swift
//  Teclado
//
//  Created by Darshan Bagmar on 09/04/20.
//  Copyright © 2020 IDmission. All rights reserved.
//

import UIKit

class CustomAlertButton: KeyboardButtonView {

    var flag:Bool?
    var keyboardType:KeyboardType?

    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    public func setup(with action: KeyboardAction, in viewController: KeyboardInputViewController, distribution: UIStackView.Distribution = .fillEqually) {
        super.setup(with: action, in: viewController)
        backgroundColor = .clearTappable
        width = action.buttonWidth(for: distribution)
        buttonView?.tintColor = action.tintColor(in: viewController)
        buttonView?.backgroundColor = action.buttonColor(for: viewController)
        buttonView?.layer.cornerRadius = 5
        buttonView?.clipsToBounds = true
        buttonView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        textLabel?.text = action.buttonText
        textLabel?.font = action.buttonFont
        textLabel?.textColor = .darkGray

//        if(action == .image(description: "MyMo", keyboardImageName: "MyMo", imageName: "MyMo")){
//            buttonView?.backgroundColor = .white
//            DispatchQueue.main.async { self.logoImageView?.image = UIImage.setImageFromBundle(name: "MyMo")}
//        }else if (action == .character("Send to wallet")) {
//            DispatchQueue.main.async { self.logoImageView?.image = UIImage.setImageFromBundle(name: "Send to wallet")}
//        }else if(action == .character("Send to ATM")){
//            DispatchQueue.main.async { self.logoImageView?.image = UIImage.setImageFromBundle(name: "Send to ATM")}
//        }else if(action == .character("History")){
//            DispatchQueue.main.async { self.logoImageView?.image = UIImage.setImageFromBundle(name: "History")}
//        }
    }
}



private extension KeyboardAction {
    
    func buttonColor(for viewController: KeyboardInputViewController) -> UIColor {
        let dark = useDarkAppearance(in: viewController)
        let asset = useDarkButton
            ? (dark ? Asset.Colors.lightSystemButton : Asset.Colors.lightSystemButton)
            : (dark ? Asset.Colors.darkButton : Asset.Colors.lightButton)
//        if(isAppButton){
//            asset = Asset.Colors.redButton
//        }
        return asset.color
    }
    
    var buttonFont: UIFont {
        return .preferredFont(forTextStyle: buttonFontStyle)
    }
    
    var buttonFontStyle: UIFont.TextStyle {
        switch self {
        case .character: return .caption1
        case .shift, .shiftDown, .backspace: return .title1
        case .switchToKeyboard(.emojis): return .title1
        default: return .body
        }
    }
    
    var buttonImage: UIImage? {
        switch self {
            case .image(_, let imageName, _): return UIImage.setImageFromBundle(name: imageName)
            case .switchKeyboard: return Asset.Images.Buttons.switchKeyboard.image
            default: return nil
        }
    }
    
    var buttonText: String? {
        switch self {
        case .backspace: return "⌫"
        case .character(let text): return text
        case .newLine: return "intro"
        case .shiftDown: return "⇪"
        case .shift: return "⇧"
        case .space: return "espacio"
        case .switchToKeyboard(let type): return buttonText(for: type)
        default: return nil
        }
    }
    
    func buttonText(for keyboardType: KeyboardType) -> String {
        switch keyboardType {
        case .alphabetic: return "ABC"
        case .emojis: return "🙂"
        case .images: return "Send to wallet"
        case .numeric: return "123"
        case .symbolic: return "#+="
        default: return "???"
        }
    }
    
    var buttonWidth: CGFloat {
        switch self {
        case .none: return 10
        case .shift, .shiftDown, .backspace: return 70
        case .space: return 100
        default: return 50
        }
    }
    
    func buttonWidth(for distribution: UIStackView.Distribution) -> CGFloat {
        let adjust = distribution == .fillProportionally
        return adjust ? buttonWidth * 100 : buttonWidth
    }
    
    func tintColor(in viewController: KeyboardInputViewController) -> UIColor {
        let dark = useDarkAppearance(in: viewController)
        let asset = useDarkButton
            ? (dark ? Asset.Colors.darkSystemButtonText : Asset.Colors.lightSystemButtonText)
            : (dark ? Asset.Colors.darkButtonText : Asset.Colors.lightButtonText)
        return asset.color
    }
    
    func useDarkAppearance(in viewController: KeyboardInputViewController) -> Bool {
        let appearance = viewController.textDocumentProxy.keyboardAppearance ?? .default
        return appearance == .dark
    }
    
    var useDarkButton: Bool {
        switch self {
        case .character, .image, .shiftDown, .space: return false
        default: return true
        }
    }
    
//    var isAppButton: Bool {
//        switch self {
//        case .image: if(self.getImageDescription == "Send to wallet"){ return true } else { return false }
//        default: return false
//        }
//    }
}
