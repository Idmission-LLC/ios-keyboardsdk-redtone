//
//  PINToolbarTextfield.swift
//  KeyboardSDK
//
//  Created by MCB-Air-036 on 21/05/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import UIKit

open class PINToolbarTextfield: UIView {

    // MARK: - Properties

    public var text: String {
        get { PINTextfield.text ?? "" }
        set { PINTextfield.text = newValue }
    }

    private weak var textDocumentProxy: UITextDocumentProxy?

    public lazy var PINTextfield: UITextField = {
        let textfiled = UITextField()
        textfiled.placeholder = "Please enter PIN"
        textfiled.font = .boldSystemFont(ofSize: 25)
        textfiled.textAlignment = .center
        textfiled.textColor = UIColor(hex: Amount_Text_Color!)
        textfiled.backgroundColor = UIColor(hex: Amount_Background_Color!)
        textfiled.layer.cornerRadius = 5.0
        return textfiled
    }()

    private lazy var sendButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(hex: SendButton_Background_Color!)
//        view.setImage(UIImage.setImageFromBundle(name: "Send"), for: .normal)
        view.setTitle("PAY", for: .normal)
        view.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 17)
        view.layer.cornerRadius = 5
        view.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        return view
    }()

    @objc func sendAction() {
        NotificationCenter.default.post(name: .PressedSendButton, object: self, userInfo: nil)
    }

    // MARK: - Initialization

    public convenience init(text: String, textDocumentProxy: UITextDocumentProxy) {
        self.init()
        self.text = text
        self.textDocumentProxy = textDocumentProxy
        PINTextfield.isHidden = true
        addTwoSubview(subview1: PINTextfield, subview2: sendButton, firstViewWidth_Multiplier: 0.66, firstViewLeft_Padding: 5)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.PINTextfield.isHidden = false
        }
    }
}
