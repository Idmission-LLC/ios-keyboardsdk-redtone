//
//  KeyboardViewController.swift
//  MyMoKeyboard
//
//  Created by MCB-Air-036 on 17/05/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import UIKit
import KeyboardSDK

class KeyboardViewController: KeyboardParentViewController {

    var userDefaults = UserDefaults(suiteName: "group.idmission.MyMoDemo")

    override func viewDidLoad() {
        super.viewDidLoad()

        let Enable_MyMO = userDefaults?.string(forKey: "Enable_MyMO") ?? ""
        let Application_Code = userDefaults?.string(forKey: "Application_Code") ?? ""
        let Sender_Name = userDefaults?.string(forKey: "Sender_Name") ?? ""
        let Login_Id = userDefaults?.string(forKey: "Login_Id") ?? ""
        let Login_Password = userDefaults?.string(forKey: "Login_Password") ?? ""
        let Merchant_Id = userDefaults?.string(forKey: "Merchant_Id") ?? ""
        let Phone_Number = userDefaults?.string(forKey: "Phone_Number") ?? ""
        let Customer_Code = userDefaults?.string(forKey: "Customer_Code") ?? ""
        let Country_Code = userDefaults?.string(forKey: "Country_Code") ?? ""
        let Currency_Code = userDefaults?.string(forKey: "Currency_Code") ?? ""
        let Minimum_Amount = userDefaults?.string(forKey: "Minimum_Amount") ?? ""
        let Maximum_Amount = userDefaults?.string(forKey: "Maximum_Amount") ?? ""
        let Language_Code = userDefaults?.string(forKey: "Language_Code") ?? ""
        let Url = userDefaults?.string(forKey: "Url") ?? ""
        let Bank_Branch_Code = userDefaults?.string(forKey: "Bank_Branch_Code") ?? ""
        let Bank_Account_No = userDefaults?.string(forKey: "Bank_Account_No") ?? ""
        let PhoneNo_Security_Required = userDefaults?.string(forKey: "PhoneNo_Security_Required") ?? ""
        let OTP_Security_Required = userDefaults?.string(forKey: "OTP_Security_Required") ?? ""
        let PIN_Security_Required = userDefaults?.string(forKey: "PIN_Security_Required") ?? ""
        let PIN_Validate_At = userDefaults?.string(forKey: "PIN_Validate_At") ?? ""
        let Customer_Security_PIN = userDefaults?.string(forKey: "Customer_Security_PIN") ?? ""
        let Email_Security_Required = userDefaults?.string(forKey: "Email_Security_Required") ?? ""
        let Face_Security_Required = userDefaults?.string(forKey: "Face_Security_Required") ?? ""

        /* UI Configuration Value */
        let ImagePath_For_BankLogo = userDefaults?.string(forKey: "ImagePath_For_BankLogo") ?? ""
        let ImagePath_For_SendToWallet = userDefaults?.string(forKey: "ImagePath_For_SendToWallet") ?? ""
        let ImagePath_For_SendToATM = userDefaults?.string(forKey: "ImagePath_For_SendToATM") ?? ""
        let ImagePath_For_History = userDefaults?.string(forKey: "ImagePath_For_History") ?? ""
        let HexColor_For_Header_Background = userDefaults?.string(forKey: "HexColor_For_Header_Background") ?? ""
        let HexColor_For_Header_SelectedText = userDefaults?.string(forKey: "HexColor_For_Header_SelectedText") ?? ""
        let HexColor_For_Header_UnSelectedText = userDefaults?.string(forKey: "HexColor_For_Header_UnSelectedText") ?? ""
        let HexColor_For_AmountText = userDefaults?.string(forKey: "HexColor_For_AmountText") ?? ""
        let HexColor_For_AmountBackgroundColor = userDefaults?.string(forKey: "HexColor_For_AmountBackgroundColor") ?? ""
        let HexColor_For_SendBackground = userDefaults?.string(forKey: "HexColor_For_SendBackground") ?? ""

        let UI_Dictionary = ["ImagePath_OF_BankLogo" : ImagePath_For_BankLogo,
                             "ImagePath_OF_SendToWallet" : ImagePath_For_SendToWallet,
                             "ImagePath_OF_SendToATM" : ImagePath_For_SendToATM,
                             "ImagePath_OF_History" : ImagePath_For_History,
                             "HexColor_OF_Header_Background": HexColor_For_Header_Background,
                             "HexColor_OF_Header_SelectedText" : HexColor_For_Header_SelectedText,
                             "HexColor_OF_Header_UnSelectedText": HexColor_For_Header_UnSelectedText,
                             "HexColor_OF_AmountText": HexColor_For_AmountText,
                             "HexColor_OF_AmountBackgroundColor": HexColor_For_AmountBackgroundColor,
                             "HexColor_OF_SendBackground":HexColor_For_SendBackground] as NSMutableDictionary

        print("UiDictionary : ", UI_Dictionary)

        initKeyboardSDK_WithUIConfiguration(enableMyMo: Enable_MyMO,
                                            applicationCode: Application_Code,
                                            senderName: Sender_Name,
                                            loginID: Login_Id,
                                            Password: Login_Password,
                                            MerchantID: Merchant_Id,
                                            PhoneNumber: Phone_Number,
                                            CustomerCode: Customer_Code,
                                            CountryCode: Country_Code,
                                            CurrencyCode: Currency_Code,
                                            minimumAmount: Minimum_Amount,
                                            maximumAmount: Maximum_Amount,
                                            languageCode: Language_Code,
                                            apiURL: Url,
                                            bankBranchCode: Bank_Branch_Code,
                                            bankAccountNumber: Bank_Account_No,
                                            receiversPhoneRequired: PhoneNo_Security_Required,
                                            selfOTPRequired: OTP_Security_Required,
                                            selfPINRequired: PIN_Security_Required,
                                            selfPINValidationAt: PIN_Validate_At,
                                            SelfPINString: Customer_Security_PIN,
                                            receiversEmailRequired: Email_Security_Required,
                                            receiversFaceRequired: Face_Security_Required,
                                            UIConfigDictionary: UI_Dictionary)
    }
}
