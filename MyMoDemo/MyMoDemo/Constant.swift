//
//  Constant.swift
//  MyMoDemo
//
//  Created by MCB-Air-036 on 04/05/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

struct Credential {
//    static let Enable_MyMO = "N"
//    static let Application_Code = "CUX"
//    static let Phone_Number = "13467925"
//    static let Sender_Name = "Shalaka"
//    static let Customer_Code = "312567"
//    static let Country_Code = "United States"
//    static let Currency_Code = "USD"
//    static let Login_Id = "mpcuxguip"
//    static let Login_Password = "Merchant#1"
//    static let Merchant_Id = "143343"
//    static let Minimum_Amount = "1"
//    static let Maximum_Amount = "2000"
//    static let Language_Code = "en_US"
//    static let Url = "https://lab.idmission.com:9043/IDS/service/ids/"
//    static let Bank_Branch_Code = "IDM_WALLET"
//    static let Bank_Account_No = ""
//    static let PhoneNo_Security_Required = "N"
//    static let OTP_Security_Required = "N"
//    static let PIN_Security_Required = "N"
//    static let PIN_Validate_At = "IDM"
//    static let Customer_Security_PIN = ""
//    static let Email_Security_Required = "N"
//    static let Face_Security_Required = "N"

    static let Enable_MyMO = "N"
    static let Application_Code = "CUX"
    static let Phone_Number = "6884648464"
    static let Sender_Name = "Ankit"
    static let Customer_Code = "45533"
    static let Country_Code = "IND"
    static let Currency_Code = "PKR"
    static let Login_Id = "MyMoDemo"
    static let Login_Password = "Merchant#1"
    static let Merchant_Id = "14144"
    static let Minimum_Amount = "1"
    static let Maximum_Amount = "1000"
    static let Language_Code = "en_US"
    static let Url = "https://demo.idmission.com/IDS/service/ids/"
    static let Bank_Branch_Code = "IDM_WALLET"
    static let Bank_Account_No = ""
    static let PhoneNo_Security_Required = "N"
    static let OTP_Security_Required = "N"
    static let PIN_Security_Required = "N"
    static let PIN_Validate_At = "IDM"
    static let Customer_Security_PIN = ""
    static let Email_Security_Required = "N"
    static let Face_Security_Required = "N"

    static let bankImagePath = ""
    static let sendToWalletImagePath = ""
    static let sendToATMImagePath = ""
    static let historyImagePath = ""

    static let headerBackgroundColor = "#C9CCD3"
    static let headerSelectedTextColor = "#555555"
    static let headerUnSelectedTextColor = "#555555"
    static let amountTextColor = "#2AA477"
    static let amountBackgroundColor = "#F2F2F7"
    static let sendBackgroundColor = "#2AA477"
}

enum SecurityType: Equatable {
    case
    NoSecurity,
    OTPSecurity,
    PINSecurity
}

struct arrayType {
    static var default_Array = ["Enable MyMo in Settings->General->Keyboard",
                                "Allow full access",
                                "To Select MyMo keyboard, long press on Globe key",
                                "SET_ENABLE_DISABLE_MYMO",
                                "Phone_Number",
                                "Sender_Name",
                                "Customer_Code",
                                "Country_Code",
                                "Currency_Code",
                                "Login_Id",
                                "Login_Password",
                                "Merchant_Id",
                                "Minimum_Amount",
                                "Maximum_Amount",
                                "Language_Code",
                                "Url",
                                "Bank_Branch_Code",
                                "Bank_Account_No",
                                "PhoneNo_Security_Required",
                                "SET_SECURITY_OPTIONS"]

    static var OTP_Security_Array = default_Array + ["OTP_Security_Required"]
    
    static var PIN_Security_Array = default_Array + ["PIN_Security_Required",
                                                     "PIN_Validate_At",
                                                     "Customer_Security_PIN"]

    static var UIConfig_Default_Array = ["ImagePath_For_BankLogo",
                                         "ImagePath_For_SendToWallet",
//                                         "ImagePath_For_SendToATM",
//                                         "ImagePath_For_History",
                                         "HexColor_For_Header_Background",
                                         "HexColor_For_Header_SelectedText",
                                         "HexColor_For_Header_UnSelectedText",
                                         "HexColor_For_AmountText",
                                         "HexColor_For_AmountBackgroundColor",
                                         "HexColor_For_SendBackground",
    ]
}

struct hearderTypeArray {

    static var headingTextArray1 = ["",
                                    "",
                                    "",
                                    "",
                                    "*Phone Number",
                                    "Sender Name",
                                    "Customer Code",
                                    "*Country Code",
                                    "*Currency Code",
                                    "*Login ID",
                                    "*Password",
                                    "*Merchant ID",
                                    "*Min Amount",
                                    "*Max Amount",
                                    "*Language Code",
                                    "*URL",
                                    "Bank Branch Code",
                                    "Bank Account Number",
                                    "",
                                    "",
                                    "Security",
                                    "",
                                    "Customer PIN"]

    static var headingTextArray2 = ["Choose Bank Logo",
                                    "Choose Send Money Logo",
//                                    "Choose Send To Wallet Logo",
//                                    "Choose Send To ATM",
//                                    "Choose History Logo",
                                    "Header Background Hex Color",
                                    "Header Selected Text Hex Color",
                                    "Header Un-Selected Text Hex Color",
                                    "Amount Text Hex Color",
                                    "Amount Background Hex Color",
                                    "Send Button Background Hex Color"]

}

enum getPlaceholderTextFor: String {
    case Phone_Number, Sender_Name, Customer_Code, Country_Code, Currency_Code, Login_Id, Login_Password, Merchant_Id,
    Minimum_Amount, Maximum_Amount, Language_Code, Url, Bank_Branch_Code, Bank_Account_No,
    OTP_Security_Required, PIN_Security_Required, Customer_Security_PIN,
    Header_Background_Hex_Color, Header_Selected_Text_Hex_Color, Header_Un_Selected_Text_Hex_Color, Amount_Text_Hex_Color, Amount_Background_Hex_Color, Send_Button_Background_Hex_Color

    var DisplayString: String {
        switch self {
            case .Phone_Number:
                return PlaceHolder.PhoneTextfield
            case .Sender_Name:
                return PlaceHolder.SenderTextfield
            case .Customer_Code:
                return PlaceHolder.CustomerCodeTextfield
            case .Country_Code:
                return PlaceHolder.CountryCodeTextfield
            case .Currency_Code:
                return PlaceHolder.CurrencyCodeTextfield
            case .Login_Id:
                return PlaceHolder.LoginIdTextfield
            case .Login_Password:
                return PlaceHolder.PasswordTextfield
            case .Merchant_Id:
                return PlaceHolder.MerchantIdTextfield
            case .Minimum_Amount:
                return PlaceHolder.MinAmountTextfield
            case .Maximum_Amount:
                return PlaceHolder.MaxAmountTextfield
            case .Language_Code:
                return PlaceHolder.LanguageTextfield
            case .Url: 
                return PlaceHolder.UrlTextfield
            case .Bank_Branch_Code:
                return PlaceHolder.BranchCodeTextfield
            case .Bank_Account_No:
                return PlaceHolder.BankAccountTextfield
            case .OTP_Security_Required:
                return PlaceHolder.OtpSecurityTextfield
            case .PIN_Security_Required:
                return PlaceHolder.PinSecurityTextfield
            case .Customer_Security_PIN:
                return PlaceHolder.CustomerPinTextfield
            case .Header_Background_Hex_Color:
                return PlaceHolder.HeaderBackgroundColor
            case .Header_Selected_Text_Hex_Color:
                return PlaceHolder.HeaderSelectedColor
            case .Header_Un_Selected_Text_Hex_Color:
                return PlaceHolder.HeaderUnselectedColor
            case .Amount_Text_Hex_Color:
                return PlaceHolder.AmountTextColor
            case .Amount_Background_Hex_Color:
                return PlaceHolder.AmountBackgroundColor
            case .Send_Button_Background_Hex_Color:
                return PlaceHolder.SendButtonBackgroundColor
        }
    }
}

struct PlaceHolder {
    static let PhoneTextfield = "Please enter phone number"
    static let SenderTextfield = "Please enter sender name"
    static let CustomerCodeTextfield = "Please enter customer code"
    static let CountryCodeTextfield = "Please enter country code"
    static let CurrencyCodeTextfield = "Please enter currency code"
    static let LoginIdTextfield = "Please enter integ user login id"
    static let PasswordTextfield = "Please enter integ user password"
    static let MerchantIdTextfield = "Please enter integ user merchant id"
    static let MinAmountTextfield = "Please enter min amount"
    static let MaxAmountTextfield = "Please enter max amount"
    static let LanguageTextfield = "Please enter language code"
    static let UrlTextfield = "Please enter URL"
    static let BranchCodeTextfield = "Please enter Branch code"
    static let BankAccountTextfield = "Please enter Bank Account number"
    static let OtpSecurityTextfield = "OTP txn Security required (Y/N)"
    static let PinSecurityTextfield = "PIN txn Security required (Y/N)"
    static let CustomerPinTextfield = "Enter customer security PIN"
    static let HeaderBackgroundColor = "Enter Hex color for header background"
    static let HeaderSelectedColor = "Enter Hex color for header selected text"
    static let HeaderUnselectedColor = "Enter Hex color for header unselected text"
    static let AmountTextColor = "Enter Hex color for amount text"
    static let AmountBackgroundColor = "Enter Hex color for amount background"
    static let SendButtonBackgroundColor = "Enter Hex color for send button background"
}
