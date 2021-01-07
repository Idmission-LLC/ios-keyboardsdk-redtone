//
//  PhoneToolbarTextfield.swift
//  MyMoKeyboard
//
//  Created by MCB-Air-036 on 08/05/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import UIKit
import ContactsUI

open class PhoneToolbarTextfield: UIView {

    // MARK: - Properties

    public var text: String {
        get { PhoneNoTextfield.text ?? "" }
        set { PhoneNoTextfield.text = newValue }
    }

    private weak var textDocumentProxy: UITextDocumentProxy?

    public lazy var PhoneNoTextfield: UITextField = {
        let textfiled = UITextField()
        textfiled.placeholder = "Receiver's Phone.no"
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

    private lazy var selectContactButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setImage(UIImage.setImageFromBundle(name: "contact"), for: .normal)
        view.layer.cornerRadius = 5
        view.addTarget(self, action: #selector(selectContactAction), for: .touchUpInside)
        return view
    }()

    @objc func sendAction() {
        NotificationCenter.default.post(name: .PressedSendButton, object: self, userInfo: nil)
    }

    @objc func selectContactAction() {

    }

    // MARK: - Initialization

    public convenience init(text: String, textDocumentProxy: UITextDocumentProxy) {
        self.init()
        self.text = text
        self.textDocumentProxy = textDocumentProxy
        PhoneNoTextfield.isHidden = true
        addThreeSubview(subview1: PhoneNoTextfield, subview2: selectContactButton, subview3: sendButton)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.PhoneNoTextfield.isHidden = false
        }
    }
}
