//
//  HeaderToolbarView.swift
//  KeyboardSDK
//
//  Created by MCB-Air-036 on 05/06/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import Foundation
import UIKit

open class HeaderToolbarView: UIView {

    // MARK: - Properties

    private weak var textDocumentProxy: UITextDocumentProxy?
    private var hasPerformedScrollToEnd = false

    open var backgroundolor: UIColor? {
        get { self.backgroundColor }
        set { self.backgroundColor = newValue }
    }

    // MARK: - Initialization

    public convenience init(text: String, textDocumentProxy: UITextDocumentProxy) {
        self.init()
        self.backgroundolor = UIColor(hex: Header_Background_Color!)
        self.textDocumentProxy = textDocumentProxy
        if Enable_MyMO == "N" {
            addTwoSubview(subview1: bankLogoButton, subview2: MyMoDisableLabel, firstViewWidth_Multiplier: 0.1665, firstViewLeft_Padding: -5)
        } else {
            addTwoSubview(subview1: bankLogoButton, subview2: scrollView, firstViewWidth_Multiplier: 0.1665, firstViewLeft_Padding: -5)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(headerReset), name: .PressedResetButton, object: nil)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Views

    private lazy var bankLogoButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        if let image =  self.getImageFromPath(imagePath: ImagePath_For_BankLogo!) {
            view.setImage(image, for: .normal)
        } else {
            view.setImage(UIImage.setImageFromBundle(name: "MyMo"), for: .normal)
        }
        view.layer.cornerRadius = 5
        return view
    }()

    public lazy var MyMoDisableLabel: UILabel = {
        let view = UILabel()
        view.text = "Please Enable MyMo"
        view.textColor = .darkGray
        view.backgroundColor = .clear
        view.font = UIFont(name: "Helvetica", size: 20)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true

        return view
    }()

    private lazy var sendToWalletButton: HeaderCustomButton = {
        let view = HeaderCustomButton()
        view.awakeFromNib()
        view.tag = 1
        if let image =  self.getImageFromPath(imagePath: ImagePath_For_SendToWallet!) {
            view.imageV.image = image
        } else {
            view.imageV.image = UIImage.setImageFromBundle(name: "Send to wallet")
        }
        view.titleV.text = "Send Money"
        view.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        return view
    }()

    private lazy var sendToATMButton: HeaderCustomButton = {
        let view = HeaderCustomButton()
        view.awakeFromNib()
        view.isHidden = true
        view.tag = 2
        if let image =  self.getImageFromPath(imagePath: ImagePath_For_SendToATM!) {
            view.imageV.image = image
        } else {
            view.imageV.image = UIImage.setImageFromBundle(name: "Send to ATM")
        }
        view.titleV.text = "Send to ATM"
        view.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        return view
    }()

    private lazy var HistoryButton: HeaderCustomButton = {
        let view = HeaderCustomButton()
        view.awakeFromNib()
        view.isHidden = true
        view.tag = 3
        if let image =  self.getImageFromPath(imagePath: ImagePath_For_History!) {
            view.imageV.image = image
        } else {
            view.imageV.image = UIImage.setImageFromBundle(name: "History")
        }
        view.titleV.text = "History"
        view.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        return view
    }()

    public lazy var scrollView: UIScrollView = {
        let buttonwidth = CGFloat(165)
        let content_Width = (buttonwidth*3)+10+10
        let content_height = CGFloat(50)

        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: content_Width, height: content_height)
        scrollView.heightAnchor.constraint(equalToConstant: content_height).isActive = true
        scrollView.backgroundColor = .clear

        let insideView = UIView(frame: CGRect(x: 0, y: 0, width: content_Width, height: content_height))
        insideView.backgroundColor = .clear
        scrollView.addSubview(insideView)

        insideView.addSubviewForHeader(subview1: sendToWalletButton, subview2: sendToATMButton, subview3: HistoryButton, singleViewWidth: buttonwidth)

        return scrollView
    }()

    @objc func sendAction(sender:HeaderCustomButton) {
        var headerButtonAction:[String: String] = ["Sender": ""]
        if sender.tag == 1 {

            sendToWalletButton.titleV.textColor = UIColor(hex: Header_SelectedText_HexColor_String!)
//            sendToATMButton.titleV.textColor = UIColor(hex: Header_UnSelectedText_HexColor_String!)
//            HistoryButton.titleV.textColor = UIColor(hex: Header_UnSelectedText_HexColor_String!)

            sendToWalletButton.titleV.font = UIFont(name: "Helvetica-Bold", size: 16)!
//            sendToATMButton.titleV.font = UIFont(name: "Helvetica", size: 16)!
//            HistoryButton.titleV.font = UIFont(name: "Helvetica", size: 16)!

            sendToWalletButton.selectionIndicator.isHidden = false
//            sendToATMButton.selectionIndicator.isHidden = true
//            HistoryButton.selectionIndicator.isHidden = true

            headerButtonAction = ["Sender": "Send to wallet"]

        } else if sender.tag == 2 {

//            sendToWalletButton.titleV.textColor = UIColor(hex: Header_UnSelectedText_HexColor_String!)
//            sendToATMButton.titleV.textColor = UIColor(hex: Header_SelectedText_HexColor_String!)
//            HistoryButton.titleV.textColor = UIColor(hex: Header_UnSelectedText_HexColor_String!)
//
//            sendToWalletButton.titleV.font = UIFont(name: "Helvetica", size: 16)!
//            sendToATMButton.titleV.font = UIFont(name: "Helvetica-Bold", size: 16)!
//            HistoryButton.titleV.font = UIFont(name: "Helvetica", size: 16)!
//
//            sendToWalletButton.selectionIndicator.isHidden = true
//            sendToATMButton.selectionIndicator.isHidden = false
//            HistoryButton.selectionIndicator.isHidden = true

            headerButtonAction = ["Sender": "Send to ATM"]

        } else if sender.tag == 3 {

//            sendToWalletButton.titleV.textColor = UIColor(hex: Header_UnSelectedText_HexColor_String!)
//            sendToATMButton.titleV.textColor = UIColor(hex: Header_UnSelectedText_HexColor_String!)
//            HistoryButton.titleV.textColor = UIColor(hex: Header_SelectedText_HexColor_String!)
//
//            sendToWalletButton.titleV.font = UIFont(name: "Helvetica", size: 16)!
//            sendToATMButton.titleV.font = UIFont(name: "Helvetica", size: 16)!
//            HistoryButton.titleV.font = UIFont(name: "Helvetica-Bold", size: 16)!
//
//            sendToWalletButton.selectionIndicator.isHidden = true
//            sendToATMButton.selectionIndicator.isHidden = true
//            HistoryButton.selectionIndicator.isHidden = false

            headerButtonAction = ["Sender": "History"]

        }

        NotificationCenter.default.post(name: .PressedSendButton, object: self, userInfo: headerButtonAction)
    }

    @objc func headerReset(notification: Notification) {

        sendToWalletButton.titleV.textColor = UIColor(hex: Header_UnSelectedText_HexColor_String!)
//        sendToATMButton.titleV.textColor = UIColor(hex: Header_UnSelectedText_HexColor_String!)
//        HistoryButton.titleV.textColor = UIColor(hex: Header_UnSelectedText_HexColor_String!)

        sendToWalletButton.titleV.font = UIFont(name: "Helvetica", size: 16)!
//        sendToATMButton.titleV.font = UIFont(name: "Helvetica", size: 16)!
//        HistoryButton.titleV.font = UIFont(name: "Helvetica", size: 16)!

        sendToWalletButton.selectionIndicator.isHidden = true
//        sendToATMButton.selectionIndicator.isHidden = true
//        HistoryButton.selectionIndicator.isHidden = true
    }
}

class HeaderCustomButton: UIButton {

    var imageV = UIImageView()
//    var imageV = UIButton()
    var titleV = UILabel()
    var selectionIndicator = UILabel()

    override func awakeFromNib() {

//        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//        titleLabel?.font = UIFont(name: "Helvetica", size: 16)!
//        titleLabel?.textAlignment = .left
//        titleLabel?.textColor = .darkGray
//        backgroundColor = .clear

        self.imageView?.isHidden = true
        self.titleLabel?.isHidden = true

        imageV.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//        imageV.image = self.imageView?.image;
        imageV.contentMode = .scaleAspectFit
//        imageV.clipsToBounds = true
        self.addSubview(imageV)

        titleV.frame = CGRect(x: 40, y: 0, width: self.bounds.width - 40, height: self.bounds.height)
        titleV.font = UIFont(name: "Helvetica", size: 16)!
        titleV.textAlignment = .left
        titleV.text = self.titleLabel?.text
        titleV.textColor = UIColor(hex: Header_UnSelectedText_HexColor_String!)
        self.addSubview(titleV)

        selectionIndicator.frame = CGRect(x: 0, y: self.bounds.height-3, width: self.bounds.width, height: 3)
        selectionIndicator.backgroundColor = .darkGray
        selectionIndicator.isHidden = true
        selectionIndicator.backgroundColor = UIColor(hex: Header_SelectedText_HexColor_String!)
        self.addSubview(selectionIndicator)

        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        imageV.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
//        imageV.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageV.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true

        titleV.translatesAutoresizingMaskIntoConstraints = false
        titleV.leadingAnchor.constraint(equalTo: imageV.trailingAnchor, constant: 5).isActive = true
        titleV.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        titleV.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        titleV.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        selectionIndicator.translatesAutoresizingMaskIntoConstraints = false
        selectionIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3).isActive = true
        selectionIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        selectionIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        selectionIndicator.heightAnchor.constraint(equalToConstant: 3).isActive = true

    }
}

extension UIView {

    func getImageFromPath(imagePath:String) -> UIImage? {

        if let imagepath = URL(string: imagePath) {
            let fileManager = FileManager.default
            let fileData = fileManager.contents(atPath: imagepath.path)
            let image = UIImage(data: fileData!)
            return image
        } else {
            let image = UIImage(named: "placeholder")
            return image
        }
    }

}
