//
//  UserDefaults.swift
//  MyMoDemo
//
//  Created by MCB-Air-036 on 04/05/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import Foundation

var userDefaults = UserDefaults(suiteName: "group.idmission.MyMoDemo")

var Enable_MyMO: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Enable_MyMO")
    }
    get {
        return (userDefaults?.string(forKey: "Enable_MyMO")) ?? ""
    }
}

var Application_Code: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Application_Code")
    }
    get {
        return (userDefaults?.string(forKey: "Application_Code")) ?? ""
    }
}

var Phone_Number: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Phone_Number")
        userDefaults?.synchronize()
    }
    get {
        return (userDefaults?.string(forKey: "Phone_Number")) ?? ""
    }
}

var Customer_Code: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Customer_Code")
    }
    get {
        return (userDefaults?.string(forKey: "Customer_Code")) ?? ""
    }
}

var Country_Code: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Country_Code")
    }
    get {
        return (userDefaults?.string(forKey: "Country_Code")) ?? ""
    }
}

var Currency_Code: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Currency_Code")
    }
    get {
        return (userDefaults?.string(forKey: "Currency_Code")) ?? ""
    }
}

var Sender_Name: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Sender_Name")
    }
    get {
        return (userDefaults?.string(forKey: "Sender_Name")) ?? ""
    }
}

var Login_Id: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Login_Id")
    }
    get {
        return (userDefaults?.string(forKey: "Login_Id")) ?? ""
    }
}

var Login_Password: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Login_Password")
    }
    get {
        return (userDefaults?.string(forKey: "Login_Password")) ?? ""
    }
}

var Merchant_Id: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Merchant_Id")
    }
    get {
        return (userDefaults?.string(forKey: "Merchant_Id")) ?? ""
    }
}

var Minimum_Amount: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Minimum_Amount")
    }
    get {
        return (userDefaults?.string(forKey: "Minimum_Amount")) ?? ""
    }
}

var Maximum_Amount: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Maximum_Amount")
    }
    get {
        return (userDefaults?.string(forKey: "Maximum_Amount")) ?? ""
    }
}

var Language_Code: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Language_Code")
    }
    get {
        return (userDefaults?.string(forKey: "Language_Code")) ?? ""
    }
}

var Url: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Url")
    }
    get {
        return (userDefaults?.string(forKey: "Url")) ?? ""
    }
}

var Bank_Branch_Code: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Bank_Branch_Code")
    }
    get {
        return (userDefaults?.string(forKey: "Bank_Branch_Code")) ?? ""
    }
}

var Bank_Account_No: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Bank_Account_No")
    }
    get {
        return (userDefaults?.string(forKey: "Bank_Account_No")) ?? ""
    }
}

var PhoneNo_Security_Required: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "PhoneNo_Security_Required")
    }
    get {
        return (userDefaults?.string(forKey: "PhoneNo_Security_Required")) ?? ""
    }
}

var OTP_Security_Required: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "OTP_Security_Required")
    }
    get {
        return (userDefaults?.string(forKey: "OTP_Security_Required")) ?? ""
    }
}

var Email_Security_Required: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Email_Security_Required")
    }
    get {
        return (userDefaults?.string(forKey: "Email_Security_Required")) ?? ""
    }
}

var Face_Security_Required: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Face_Security_Required")
    }
    get {
        return (userDefaults?.string(forKey: "Face_Security_Required")) ?? ""
    }
}

var PIN_Security_Required: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "PIN_Security_Required")
    }
    get {
        return (userDefaults?.string(forKey: "PIN_Security_Required")) ?? ""
    }
}

var PIN_Validate_At: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "PIN_Validate_At")
    }
    get {
        return (userDefaults?.string(forKey: "PIN_Validate_At")) ?? ""
    }
}

var Customer_Security_PIN: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "Customer_Security_PIN")
    }
    get {
        return (userDefaults?.string(forKey: "Customer_Security_PIN")) ?? ""
    }
}

//MARK:- UIImage Configuration Values
var ImagePath_For_BankLogo: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "ImagePath_For_BankLogo")
    }
    get {
        return (userDefaults?.string(forKey: "ImagePath_For_BankLogo")) ?? ""
    }
}

var ImagePath_For_SendToWallet: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "ImagePath_For_SendToWallet")
    }
    get {
        return (userDefaults?.string(forKey: "ImagePath_For_SendToWallet")) ?? ""
    }
}

var ImagePath_For_SendToATM: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "ImagePath_For_SendToATM")
    }
    get {
        return (userDefaults?.string(forKey: "ImagePath_For_SendToATM")) ?? ""
    }
}

var ImagePath_For_History: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "ImagePath_For_History")
    }
    get {
        return (userDefaults?.string(forKey: "ImagePath_For_History")) ?? ""
    }
}

//MARK:- UI Configuration Values

var HexColor_For_Header_Background: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "HexColor_For_Header_Background")
    }
    get {
        return (userDefaults?.string(forKey: "HexColor_For_Header_Background")) ?? "#C9CCD3"
    }
}

var HexColor_For_Header_SelectedText: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "HexColor_For_Header_SelectedText")
    }
    get {
        return (userDefaults?.string(forKey: "HexColor_For_Header_SelectedText")) ?? "#555555"
    }
}

var HexColor_For_Header_UnSelectedText: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "HexColor_For_Header_UnSelectedText")
    }
    get {
        return (userDefaults?.string(forKey: "HexColor_For_Header_UnSelectedText")) ?? "#555555"
    }
}

var HexColor_For_AmountText: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "HexColor_For_AmountText")
    }
    get {
        return (userDefaults?.string(forKey: "HexColor_For_AmountText")) ?? "#2AA477"
    }
}

var HexColor_For_AmountBackgroundColor: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "HexColor_For_AmountBackgroundColor")
    }
    get {
        return (userDefaults?.string(forKey: "HexColor_For_AmountBackgroundColor")) ?? "#F2F2F7"
    }
}

var HexColor_For_SendBackground: String {
    set(value) {
        userDefaults?.set(value as String, forKey: "HexColor_For_SendBackground")
    }
    get {
        return (userDefaults?.string(forKey: "HexColor_For_SendBackground")) ?? "#2AA477"
    }
}
