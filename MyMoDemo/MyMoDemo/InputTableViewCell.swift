//
//  TableViewCell.swift
//  MyMoDemo
//
//  Created by MCB-Air-036 on 04/05/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import UIKit

protocol viewControllerDelegate: class {
    func reloadInputTableview_WithFocus(flag:Bool)
    func reloadInputTableview_With_SecurityType(securityMode:SecurityType)
    func showAlertWith(titleString:String, messageString:String)
    func setImage(forName name:String)
    func getImage(forName name:String) -> UIImage
}

class InputTableViewCell: UITableViewCell {

    //MARK:- Cell Properties
    @IBOutlet weak var linkButton: UIButton!

    @IBOutlet weak var inputview: UIView!
    @IBOutlet weak var textfieldName: UILabel!
    @IBOutlet weak var inputTextField: UITextField!

    @IBOutlet weak var yesNoView: UIView!
    @IBOutlet weak var yesNoLabel: UILabel!
    @IBOutlet weak var yesNoSegment: UISegmentedControl!

    @IBOutlet weak var securitySegment: UISegmentedControl!
    
    weak var delegate: viewControllerDelegate?

    //MARK:- Cell Default Method
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    //MARK:- Cell Data Set
    func setData(textString:String, placeholderString: String, indexpath:IndexPath, selectedSegment:Int) {
        if indexpath.row == 0 || indexpath.row == 1 || indexpath.row == 2 || indexpath.row == 3 {
            self.linkButton.tag = indexpath.row+1
            self.linkButton.isHidden = false
            self.inputview.isHidden = true
            self.securitySegment.isHidden = true
            self.yesNoView.isHidden = true

            if textString == "SET_ENABLE_DISABLE_MYMO" {
                Enable_MyMO == "Y" ? self.linkButton.setTitle("DISABLE MYMO", for: .normal) : self.linkButton.setTitle("ENABLE MYMO", for: .normal)
            } else {
                self.linkButton.setTitle(textString, for: .normal)
            }
            if indexpath.row == 0 {
                self.linkButton.titleLabel?.textColor = .red
                self.linkButton.backgroundColor = .clear
                self.linkButton.underlineText(bool: true)
            } else if indexpath.row == 1 {
                self.linkButton.titleLabel?.textColor = .black
                self.linkButton.backgroundColor = .clear
                self.linkButton.underlineText(bool: false)
            } else if indexpath.row == 2 {
                self.linkButton.titleLabel?.textColor = .black
                self.linkButton.backgroundColor = .clear
                self.linkButton.underlineText(bool: false)
            } else {
                self.linkButton.titleLabel?.textColor = .black
                self.linkButton.backgroundColor = .lightGray
                self.linkButton.underlineText(bool: false)
            }
        } else if textString == "SET_SECURITY_OPTIONS" {
            self.securitySegment.tag = indexpath.row+1
            self.linkButton.isHidden = true
            self.inputview.isHidden = true
            self.securitySegment.isHidden = false
            self.yesNoView.isHidden = true

            self.securitySegment.selectedSegmentIndex = selectedSegment
        } else if textString == "PhoneNo_Security_Required" ||  textString == "PIN_Validate_At" {
            self.yesNoSegment.tag = indexpath.row+1
            self.linkButton.isHidden = true
            self.inputview.isHidden = true
            self.securitySegment.isHidden = true
            self.yesNoView.isHidden = false

            if textString == "PhoneNo_Security_Required" {
                self.yesNoLabel.text = "Receiver Phone Security Required ? :"
                self.yesNoSegment.setTitle("YES", forSegmentAt: 0)
                self.yesNoSegment.setTitle("NO", forSegmentAt: 1)

                if userDefaults?.string(forKey: textString) == "Y" {
                    self.yesNoSegment.selectedSegmentIndex = 0
                } else {
                    self.yesNoSegment.selectedSegmentIndex = 1
                }
            } else if textString == "PIN_Validate_At" {
                self.yesNoLabel.text = "PIN Validate At? :"
                self.yesNoSegment.setTitle("IDM", forSegmentAt: 0)
                self.yesNoSegment.setTitle("BANK", forSegmentAt: 1)

                if userDefaults?.string(forKey: textString) == "IDM" { self.yesNoSegment.selectedSegmentIndex = 0 } else { self.yesNoSegment.selectedSegmentIndex = 1 }
            }
            
        } else {
            self.inputTextField.tag = indexpath.row+1
            self.linkButton.isHidden = true
            self.inputview.isHidden = false
            self.securitySegment.isHidden = true
            self.yesNoView.isHidden = true

            // Set Textfield Placeholder Text
            self.inputTextField.placeholder = placeholderString

            // Set Textfield Text
            self.inputTextField.text = userDefaults?.string(forKey: textString) ?? ""

            // Set Textfield Label Name
            if textString == "OTP_Security_Required" || textString == "PIN_Security_Required" {
                let trimmedString = textString.replacingOccurrences(of: "_Security_Required", with: " ")
                self.textfieldName.text = "*" + trimmedString.appending(hearderTypeArray.headingTextArray1[indexpath.row])
                self.inputTextField.isEnabled = false
                self.inputTextField.textColor = .gray
            } else {
                self.textfieldName.text = hearderTypeArray.headingTextArray1[indexpath.row]
                self.inputTextField.isEnabled = true
                self.inputTextField.textColor = .black
            }

            // Set Required Textfield Label Red If Textfield Text Is Blank
            if (self.textfieldName.text?.contains("*"))! &&  (self.inputTextField.text?.count == 0) {
                self.textfieldName.textColor = .red
            } else {
                self.textfieldName.textColor = .gray
            }

        }
    }

    //MARK:- Button Action
    @IBAction func buttonAction(_ sender:UIButton) {
        print("Button_Pressed_At_Index", sender.tag)
        if sender.tag == 1 {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        } else if sender.tag == 4 {
            if sender.title(for: .normal) == "ENABLE MYMO" {
                self.checkRequiredField_And_EnableKeyboard()
            } else if sender.title(for: .normal) == "DISABLE MYMO" {
                Enable_MyMO = "N"
                self.delegate?.reloadInputTableview_WithFocus(flag: true)
            }
        }
    }

    @IBAction func securitySegmentAction(_ sender: UISegmentedControl) {
        switch securitySegment.selectedSegmentIndex
        {
            case 0:
                self.delegate?.reloadInputTableview_With_SecurityType(securityMode: .NoSecurity)
            case 1:
                self.delegate?.reloadInputTableview_With_SecurityType(securityMode: .OTPSecurity)
            case 2:
                self.delegate?.reloadInputTableview_With_SecurityType(securityMode: .PINSecurity)
            default:
                break
        }
    }

    @IBAction func yesNoSegmentAction(_ sender: UISegmentedControl) {

        if sender.tag == 19 {
            switch yesNoSegment.selectedSegmentIndex
            {
                case 0:
                    PhoneNo_Security_Required = "Y"
                case 1:
                    PhoneNo_Security_Required = "N"
                default:
                    break
            }
        } else if sender.tag == 22 {
            switch yesNoSegment.selectedSegmentIndex
            {
                case 0:
                    PIN_Validate_At = "IDM"
                case 1:
                    PIN_Validate_At = "BANK"
                default:
                    break
            }

        }
    }
}

extension InputTableViewCell {

    func checkRequiredField_And_EnableKeyboard() {

        if Phone_Number.count == 0 || Country_Code.count == 0 || Currency_Code.count == 0 || Login_Id.count == 0 || Login_Password.count == 0 || Merchant_Id.count == 0 || Minimum_Amount.count == 0 || Maximum_Amount.count == 0 || Language_Code.count == 0 || Url.count == 0 {
            self.delegate?.showAlertWith(titleString: "Alert", messageString: "Please enter values in required fields")
            self.delegate?.reloadInputTableview_WithFocus(flag: false)
        } else if PIN_Security_Required == "Y" && PIN_Validate_At == "IDM" && Customer_Security_PIN.count == 0 {
            self.delegate?.showAlertWith(titleString: "Alert", messageString: "Please enter Customer PIN value")
            self.delegate?.reloadInputTableview_WithFocus(flag: false)
        } else {
            Enable_MyMO = "Y"
            self.delegate?.reloadInputTableview_WithFocus(flag: true)
        }
    }
}
