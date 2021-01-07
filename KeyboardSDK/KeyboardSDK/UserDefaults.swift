//
//  UserDefaults.swift
//  MyMoDemo
//
//  Created by MCB-Air-036 on 04/05/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import Foundation

var userDefaults = UserDefaults.standard

var Enable_MyMO: String {
    set(value) {
        userDefaults.set(value as String, forKey: "paymentEnabled")
    }
    get {
        return (userDefaults.string(forKey: "paymentEnabled")) ?? ""
    }
}

var Application_Code: String {
    set(value) {
        userDefaults.set(value as String, forKey: "applicationCode")
    }
    get {
        return (userDefaults.string(forKey: "applicationCode")) ?? ""
    }
}

var Phone_Number: String {
    set(value) {
        userDefaults.set(value as String, forKey: "phoneNumber")
    }
    get {
        return (userDefaults.string(forKey: "phoneNumber")) ?? ""
    }
}

var Customer_Code: String {
    set(value) {
        userDefaults.set(value as String, forKey: "customerCode")
    }
    get {
        return (userDefaults.string(forKey: "customerCode")) ?? ""
    }
}

var Country_Code: String {
    set(value) {
        userDefaults.set(value as String, forKey: "countryCode")
    }
    get {
        return (userDefaults.string(forKey: "countryCode")) ?? ""
    }
}

var Currency_Code: String {
    set(value) {
        userDefaults.set(value as String, forKey: "currencyCode")
    }
    get {
        return (userDefaults.string(forKey: "currencyCode")) ?? ""
    }
}

var Sender_Name: String {
    set(value) {
        userDefaults.set(value as String, forKey: "integSenderName")
    }
    get {
        return (userDefaults.string(forKey: "integSenderName")) ?? ""
    }
}

var Login_Id: String {
    set(value) {
        userDefaults.set(value as String, forKey: "integLoginId")
    }
    get {
        return (userDefaults.string(forKey: "integLoginId")) ?? ""
    }
}

var Login_Password: String {
    set(value) {
        userDefaults.set(value as String, forKey: "integPassword")
    }
    get {
        return (userDefaults.string(forKey: "integPassword")) ?? ""
    }
}

var Merchant_Id: String {
    set(value) {
        userDefaults.set(value as String, forKey: "integMerchantId")
    }
    get {
        return (userDefaults.string(forKey: "integMerchantId")) ?? ""
    }
}

var Minimum_Amount: String {
    set(value) {
        userDefaults.set(value as String, forKey: "minAmount")
    }
    get {
        return (userDefaults.string(forKey: "minAmount")) ?? ""
    }
}

var Maximum_Amount: String {
    set(value) {
        userDefaults.set(value as String, forKey: "maxAmount")
    }
    get {
        return (userDefaults.string(forKey: "maxAmount")) ?? ""
    }
}

var Language_Code: String {
    set(value) {
        userDefaults.set(value as String, forKey: "language")
    }
    get {
        return (userDefaults.string(forKey: "language")) ?? ""
    }
}

var Url: String {
    set(value) {
        userDefaults.set(value as String, forKey: "postURL")
    }
    get {
        return (userDefaults.string(forKey: "postURL")) ?? ""
    }
}

var Bank_Branch_Code: String {
    set(value) {
        userDefaults.set(value as String, forKey: "branchCode")
    }
    get {
        return (userDefaults.string(forKey: "branchCode")) ?? ""
    }
}

var Bank_Account_No: String {
    set(value) {
        userDefaults.set(value as String, forKey: "bankAccountNo")
    }
    get {
        return (userDefaults.string(forKey: "bankAccountNo")) ?? ""
    }
}

var PhoneNo_Security_Required: String {
    set(value) {
        userDefaults.set(value as String, forKey: "txnSecurityReceiverPhoneNo")
    }
    get {
        return (userDefaults.string(forKey: "txnSecurityReceiverPhoneNo")) ?? ""
    }
}

var OTP_Security_Required: String {
    set(value) {
        userDefaults.set(value as String, forKey: "txnSecurityOtp")
    }
    get {
        return (userDefaults.string(forKey: "txnSecurityOtp")) ?? ""
    }
}

var Email_Security_Required: String {
    set(value) {
        userDefaults.set(value as String, forKey: "txnSecurityReceiverEmail")
    }
    get {
        return (userDefaults.string(forKey: "txnSecurityReceiverEmail")) ?? ""
    }
}

var Face_Security_Required: String {
    set(value) {
        userDefaults.set(value as String, forKey: "txnSecurityFace")
    }
    get {
        return (userDefaults.string(forKey: "txnSecurityFace")) ?? ""
    }
}

var PIN_Security_Required: String {
    set(value) {
        userDefaults.set(value as String, forKey: "PIN_Security_Required")
    }
    get {
        return (userDefaults.string(forKey: "PIN_Security_Required")) ?? ""
    }
}

var PIN_Validate_At: String {
    set(value) {
        userDefaults.set(value as String, forKey: "PIN_Validate_At")
    }
    get {
        return (userDefaults.string(forKey: "PIN_Validate_At")) ?? ""
    }
}

var Customer_Security_PIN: String {
    set(value) {
        userDefaults.set(value as String, forKey: "Customer_Security_PIN")
    }
    get {
        return (userDefaults.string(forKey: "Customer_Security_PIN")) ?? ""
    }
}

//MARK:- UIImage Configuration Values
var ImagePath_For_BankLogo: String? {
    set(value) {
        userDefaults.set(value, forKey: "ImagePath_For_BankLogo")
    }
    get {
        return (userDefaults.string(forKey: "ImagePath_For_BankLogo")) ?? ""
    }
}

var ImagePath_For_SendToWallet: String? {
    set(value) {
        userDefaults.set(value, forKey: "ImagePath_For_SendToWallet")
    }
    get {
        return (userDefaults.string(forKey: "ImagePath_For_SendToWallet")) ?? ""
    }
}

var ImagePath_For_SendToATM: String? {
    set(value) {
        userDefaults.set(value, forKey: "ImagePath_For_SendToATM")
    }
    get {
        return (userDefaults.string(forKey: "ImagePath_For_SendToATM")) ?? ""
    }
}

var ImagePath_For_History: String? {
    set(value) {
        userDefaults.set(value, forKey: "ImagePath_For_History")
    }
    get {
        return (userDefaults.string(forKey: "ImagePath_For_History")) ?? ""
    }
}

//MARK:- UI Configuration Values

var Header_SelectedText_HexColor_String: String? {
    set(value) {
        userDefaults.set(value, forKey: "Header_SelectedText_HexColor_String")
    }
    get {
        return (userDefaults.string(forKey: "Header_SelectedText_HexColor_String")) ?? "#555555"
    }
}

var Header_UnSelectedText_HexColor_String: String? {
    set(value) {
        userDefaults.set(value, forKey: "Header_UnSelectedText_HexColor_String")
    }
    get {
        return (userDefaults.string(forKey: "Header_UnSelectedText_HexColor_String")) ?? "#555555"
    }
}

var Header_Background_Color: String? {
    set(value) {
        userDefaults.set(value, forKey: "Header_Background_Color")
    }
    get {
        return (userDefaults.string(forKey: "Header_Background_Color")) ?? "#C9CCD3"
    }
}

var Amount_Text_Color: String? {
    set(value) {
        userDefaults.set(value, forKey: "Amount_Text_Color")
    }
    get {
        return (userDefaults.string(forKey: "Amount_Text_Color")) ?? "#2AA477"
    }
}

var Amount_Background_Color: String? {
    set(value) {
        userDefaults.set(value, forKey: "Amount_Background_Color")
    }
    get {
        return (userDefaults.string(forKey: "Amount_Background_Color")) ?? "#F2F2F7"
    }
}

var SendButton_Background_Color: String? {
    set(value) {
        userDefaults.set(value, forKey: "SendButton_Background_Color")
    }
    get {
        return (userDefaults.string(forKey: "SendButton_Background_Color")) ?? "#2AA477"
    }
}
