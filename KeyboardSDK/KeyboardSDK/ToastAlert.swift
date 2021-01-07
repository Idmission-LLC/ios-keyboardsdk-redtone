//
//  ToastAlert.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This alerter presents keyboard alert messages at the center
 of the keyboard.

 To customize the appearance, you can modify the `appearance`
 property. You can also override the `style` functions.

 TODO: This should be refactored to use the appearance proxy
 styling approach, e.g. combined with theme classes.
 */
open class ToastAlert: KeyboardAlert {

    // MARK: - Public Properties
    public let appearance: Appearance

    // MARK: - Initialization

    public init(appearance: Appearance = Appearance()) {
        self.appearance = appearance
    }

    public struct Appearance {
        public init() {}
        public var backgroundColor: UIColor = .white
        public var cornerRadius: CGFloat = 10
        public var font: UIFont = .systemFont(ofSize: 20)
        public var horizontalPadding: CGFloat = 20
        public var textColor: UIColor = .black
    }


    // MARK: - Public functions

    open func alert(message: String, in view: UIView, withDuration duration: Double) {
        let alertView = createAlertView(withText: message, in: view)
        view.addSubview(alertView)
        removeSubview(alertView, withDuration: duration)
    }

    open func processingView(showSpinner: Bool, in view: UIView) {
        if showSpinner {
            let alertView = createAlertView(withText: "Processing...", in: view)
            alertView.tag = 9787
            view.addSubview(alertView)
        } else {
            view.viewWithTag(9787)?.removeFromSuperview()
        }
    }

    open func removeSubview(_ view: UIView, withDuration duration: Double) {
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
        }, completion: { _ in
            view.removeFromSuperview()
        })
    }

}


// MARK: - Private Functions

private extension ToastAlert {

    func createAlertView(withText text: String, in view: UIView) -> UIView {

        //MARK: Transparent Background View
        let alertTransparentView = UIView(frame: view.frame)
        alertTransparentView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        alertTransparentView.autoresizingMask = .flexibleWidth

        //MARK: White Background View
        let whiteBackgroundView = UIView(frame: CGRect(x: view.bounds.origin.x+30, y: view.bounds.origin.y+30, width: view.bounds.size.width-60, height: view.bounds.size.height-60))
        whiteBackgroundView.backgroundColor = .white
        whiteBackgroundView.layer.cornerRadius = appearance.cornerRadius
        whiteBackgroundView.applyShadow(.standardButtonShadow)
        whiteBackgroundView.autoresizingMask = .centerInParent
        alertTransparentView.addSubview(whiteBackgroundView)

        if text == "You sent: $" + amountPagar {

            //MARK: Background Graphics Image View
            let GraphicsImageView = UIImageView()
            GraphicsImageView.image = UIImage.setImageFromBundle(name: "Background Graphics")
            GraphicsImageView.contentMode = .scaleToFill
            GraphicsImageView.backgroundColor = .clear
            whiteBackgroundView.addSubview(GraphicsImageView)
            /* Image Constraints */
            GraphicsImageView.translatesAutoresizingMaskIntoConstraints = false
            GraphicsImageView.topAnchor.constraint(equalTo: whiteBackgroundView.topAnchor).isActive = true
            GraphicsImageView.leadingAnchor.constraint(equalTo: whiteBackgroundView.leadingAnchor).isActive = true
            GraphicsImageView.widthAnchor.constraint(equalTo: whiteBackgroundView.widthAnchor, multiplier: 0.40).isActive = true
            GraphicsImageView.heightAnchor.constraint(equalTo: whiteBackgroundView.heightAnchor, multiplier: 0.70).isActive = true

            //MARK: MyMo Image View
            let alertImageView = UIImageView()
            alertImageView.image = UIImage.setImageFromBundle(name: "MyMo")
            alertImageView.contentMode = .scaleAspectFit
            alertImageView.backgroundColor = .clear
            whiteBackgroundView.addSubview(alertImageView)
            /* Image Constraints */
            alertImageView.translatesAutoresizingMaskIntoConstraints = false
            alertImageView.topAnchor.constraint(equalTo: whiteBackgroundView.topAnchor, constant: 25).isActive = true
            alertImageView.centerXAnchor.constraint(equalTo: whiteBackgroundView.centerXAnchor, constant: 0).isActive = true
            alertImageView.widthAnchor.constraint(equalTo: whiteBackgroundView.widthAnchor, multiplier: 0.40).isActive = true
            alertImageView.heightAnchor.constraint(equalTo: whiteBackgroundView.heightAnchor, multiplier: 0.40).isActive = true

            //MARK: AlertMessage Label
            let alertMsgLabel = UILabel()
            alertMsgLabel.attributedText = text.getAttributedString()
            alertMsgLabel.backgroundColor = .clear
            alertMsgLabel.lineBreakMode = .byWordWrapping
            alertMsgLabel.textAlignment = .center
            alertMsgLabel.numberOfLines = 0
            alertMsgLabel.sizeToFit()
            whiteBackgroundView.addSubview(alertMsgLabel)
            /* Label Constraints */
            alertMsgLabel.translatesAutoresizingMaskIntoConstraints = false
            alertMsgLabel.topAnchor.constraint(equalTo: alertImageView.bottomAnchor, constant: 2).isActive = true
            alertMsgLabel.centerXAnchor.constraint(equalTo: whiteBackgroundView.centerXAnchor, constant: 0).isActive = true
            alertMsgLabel.widthAnchor.constraint(equalTo: whiteBackgroundView.widthAnchor, multiplier: 0.95).isActive = true
            alertMsgLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true

        } else if text == "Processing..." {

            //MARK: Activity Indicatior View
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.hidesWhenStopped = true
            if #available(iOSApplicationExtension 13.0, *) {
                activityIndicator.style = UIActivityIndicatorView.Style.large
            } else {
                activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
            }
            activityIndicator.color = .red
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
            activityIndicator.startAnimating()
            whiteBackgroundView.addSubview(activityIndicator)
            /* ActivityIndicator Constraints */
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.topAnchor.constraint(equalTo: whiteBackgroundView.topAnchor, constant: 25).isActive = true
            activityIndicator.centerXAnchor.constraint(equalTo: whiteBackgroundView.centerXAnchor, constant: 0).isActive = true
            activityIndicator.widthAnchor.constraint(equalTo: whiteBackgroundView.widthAnchor, multiplier: 0.40).isActive = true
            activityIndicator.heightAnchor.constraint(equalTo: whiteBackgroundView.heightAnchor, multiplier: 0.40).isActive = true

            //MARK: SpinnerMessage Label
            let alertMsgLabel = UILabel()
            alertMsgLabel.text = text
            alertMsgLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            alertMsgLabel.textColor = .gray
            alertMsgLabel.backgroundColor = .clear
            alertMsgLabel.lineBreakMode = .byWordWrapping
            alertMsgLabel.textAlignment = .center
            alertMsgLabel.numberOfLines = 0
            alertMsgLabel.sizeToFit()
            whiteBackgroundView.addSubview(alertMsgLabel)
            /* Label Constraints */
            alertMsgLabel.translatesAutoresizingMaskIntoConstraints = false
            alertMsgLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 2).isActive = true
            alertMsgLabel.centerXAnchor.constraint(equalTo: whiteBackgroundView.centerXAnchor, constant: 0).isActive = true
            alertMsgLabel.widthAnchor.constraint(equalTo: whiteBackgroundView.widthAnchor, multiplier: 0.95).isActive = true
            alertMsgLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true

        } else {

            //MARK: RedAlert Image View
            let alertImageView = UIImageView()
            alertImageView.image = UIImage.setImageFromBundle(name: "Alert")
            alertImageView.contentMode = .scaleAspectFit
            alertImageView.backgroundColor = .clear
            whiteBackgroundView.addSubview(alertImageView)
            /* Image Constraints */
            alertImageView.translatesAutoresizingMaskIntoConstraints = false
            alertImageView.topAnchor.constraint(equalTo: whiteBackgroundView.topAnchor, constant: 25).isActive = true
            alertImageView.centerXAnchor.constraint(equalTo: whiteBackgroundView.centerXAnchor, constant: 0).isActive = true
            alertImageView.widthAnchor.constraint(equalTo: whiteBackgroundView.widthAnchor, multiplier: 0.40).isActive = true
            alertImageView.heightAnchor.constraint(equalTo: whiteBackgroundView.heightAnchor, multiplier: 0.40).isActive = true

            //MARK: AlertMessage Label
            let alertMsgLabel = UILabel()
            alertMsgLabel.text = text
            alertMsgLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            alertMsgLabel.textColor = .gray
            alertMsgLabel.backgroundColor = .clear
            alertMsgLabel.lineBreakMode = .byWordWrapping
            alertMsgLabel.textAlignment = .center
            alertMsgLabel.numberOfLines = 0
            alertMsgLabel.sizeToFit()
            whiteBackgroundView.addSubview(alertMsgLabel)
            /* Label Constraints */
            alertMsgLabel.translatesAutoresizingMaskIntoConstraints = false
            alertMsgLabel.topAnchor.constraint(equalTo: alertImageView.bottomAnchor, constant: 2).isActive = true
            alertMsgLabel.centerXAnchor.constraint(equalTo: whiteBackgroundView.centerXAnchor, constant: 0).isActive = true
            alertMsgLabel.widthAnchor.constraint(equalTo: whiteBackgroundView.widthAnchor, multiplier: 0.95).isActive = true
            alertMsgLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true

        }

        return alertTransparentView
    }

}


extension String {
    func getAttributedString() -> NSAttributedString {

        let newstring = self.replacingOccurrences(of: " $", with: "\n")
        let attributedString = NSMutableAttributedString(string: newstring)

        let range0 = (newstring as NSString).range(of: "You sent:")
        let range1 = (newstring as NSString).range(of: "" + amountPagar)

        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range0)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: Amount_Text_Color!), range: range1)

        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 25), range: range0)
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 40), range: range1)

        return attributedString
    }
}
