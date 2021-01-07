//
//  KeyboardParentViewController.swift
//  Teclado
//
//  Created by Pranjal Lamba on 18/02/20.
//  Copyright © 2020 IDmission. All rights reserved.
//

/**
 This demo app handles system actions as normal (e.g. change
 keyboard, space, new line etc.), injects strings and emojis
 into the text proxy and handles the rightmost images in the
 emoji keyboard by copying them to the pasteboard on tap and
 saving them to the user's photo album on long press.
 
 IMPORTANT: To use this demo keyboard, you have to enable it
 in system settings ("Settings/General/Keyboards") then give
 it full access (this requires enabling `RequestsOpenAccess`
 in `Info.plist`) if you want to use image buttons. You must
 also add a `NSPhotoLibraryAddUsageDescription` to your host
 app's `Info.plist` if you want to be able to save images to
 the photo album. This is already taken care of in this demo
 app, so you can just copy the setup into your own app.
 
 The keyboard is setup in `viewDidAppear(...)` since this is
 when `needsInputModeSwitchKey` first gets the correct value.
 Before this point, the value is `true` even if it should be
 `false`. If you find a way to solve this bug, you can setup
 the keyboard earlier.
 
 The autocomplete parts of this class is the first iteration
 of autocomplete support in KeyboardKit. The intention is to
 move these parts to `KeyboardInputViewController` and a new
 api for working with autocomplete.
 
 **IMPORTANT** `textWillChange` and `textDidChange` does not
 trigger when a user types and text is sent to the proxy. It
 however works when the text cursor changes its position, so
 I therefore use a (hopefully temporary) hack, by starting a
 timer that triggers each second and moves the cursor. Since
 this is a nasty hack, it may have yet to be discovered side
 effects. If so, please let me know.
 */

import UIKit

open class KeyboardParentViewController: KeyboardInputViewController {

    // MARK: - View Controller Lifecycle

    override open func viewDidLoad() {
        UserDefaults.standard.set(false, forKey: KeyBoardKeys.capsLocked)
        super.viewDidLoad()
        keyboardActionHandler = DemoKeyboardActionHandler(inputViewController: self)
        super.viewWillAppear(true)
    }
    
//    override open func viewWillAppear(_ animated: Bool) {
//    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboard()
    }

    public func initKeyboardSDK(enableMyMo:String, applicationCode:String, senderName:String, loginID:String, Password:String, MerchantID:String, PhoneNumber:String, CustomerCode:String, CountryCode:String, CurrencyCode:String, minimumAmount:String, maximumAmount:String, languageCode:String, apiURL:String, bankBranchCode:String, bankAccountNumber:String, receiversPhoneRequired:String, selfOTPRequired:String, selfPINRequired:String, selfPINValidationAt:String, SelfPINString:String, receiversEmailRequired:String, receiversFaceRequired:String) {

        //Set values in User Defaults
        Application_Code = applicationCode
        Sender_Name = senderName
        Login_Id = loginID
        Login_Password = Password
        Merchant_Id = MerchantID
        Phone_Number = PhoneNumber
        Customer_Code = CustomerCode
        Country_Code = CountryCode
        Currency_Code = CurrencyCode
        Minimum_Amount = minimumAmount
        Maximum_Amount = maximumAmount
        Language_Code = languageCode
        Url = apiURL
        Bank_Branch_Code = bankBranchCode
        Bank_Account_No = bankAccountNumber

        if enableMyMo == "Y" || enableMyMo == "y" { (Enable_MyMO = "Y") }
        else{ (Enable_MyMO = "N") }

        if receiversPhoneRequired == "Y" || receiversPhoneRequired == "y" { (PhoneNo_Security_Required = "Y") }
        else{ (PhoneNo_Security_Required = "N") }

        if selfOTPRequired == "Y" || selfOTPRequired == "y"{ (OTP_Security_Required = "Y") }
        else{ (OTP_Security_Required = "N") }

        if selfPINRequired == "Y" || selfPINRequired == "y"{ (PIN_Security_Required = "Y") }
        else{ (PIN_Security_Required = "N") }

        PIN_Validate_At = selfPINValidationAt
        Customer_Security_PIN = SelfPINString

        if receiversEmailRequired == "Y" || receiversEmailRequired == "y" { (Email_Security_Required = "Y") }
        else{ (Email_Security_Required = "N") }

        if receiversFaceRequired == "Y" || receiversFaceRequired == "y" { (Face_Security_Required = "Y") }
        else{ (Face_Security_Required = "N") }

        if PIN_Security_Required == "Y" && PIN_Validate_At == "IDM" {
            self.createPINUpdateRequest()
        }
    }

    public func initKeyboardSDK_WithUIConfiguration(enableMyMo:String, applicationCode:String, senderName:String, loginID:String, Password:String, MerchantID:String, PhoneNumber:String, CustomerCode:String, CountryCode:String, CurrencyCode:String, minimumAmount:String, maximumAmount:String, languageCode:String, apiURL:String, bankBranchCode:String, bankAccountNumber:String, receiversPhoneRequired:String, selfOTPRequired:String, selfPINRequired:String, selfPINValidationAt:String, SelfPINString:String, receiversEmailRequired:String, receiversFaceRequired:String, UIConfigDictionary: NSMutableDictionary) {

        //Set values in User Defaults
        Application_Code = applicationCode
        Sender_Name = senderName
        Login_Id = loginID
        Login_Password = Password
        Merchant_Id = MerchantID
        Phone_Number = PhoneNumber
        Customer_Code = CustomerCode
        Country_Code = CountryCode
        Currency_Code = CurrencyCode
        Minimum_Amount = minimumAmount
        Maximum_Amount = maximumAmount
        Language_Code = languageCode
        Url = apiURL
        Bank_Branch_Code = bankBranchCode
        Bank_Account_No = bankAccountNumber

        if enableMyMo == "Y" || enableMyMo == "y" { (Enable_MyMO = "Y") }
        else{ (Enable_MyMO = "N") }

        if receiversPhoneRequired == "Y" || receiversPhoneRequired == "y" { (PhoneNo_Security_Required = "Y") }
        else{ (PhoneNo_Security_Required = "N") }

        if selfOTPRequired == "Y" || selfOTPRequired == "y"{ (OTP_Security_Required = "Y") }
        else{ (OTP_Security_Required = "N") }

        if selfPINRequired == "Y" || selfPINRequired == "y"{ (PIN_Security_Required = "Y") }
        else{ (PIN_Security_Required = "N") }

        PIN_Validate_At = selfPINValidationAt
        Customer_Security_PIN = SelfPINString

        if receiversEmailRequired == "Y" || receiversEmailRequired == "y" { (Email_Security_Required = "Y") }
        else{ (Email_Security_Required = "N") }

        if receiversFaceRequired == "Y" || receiversFaceRequired == "y" { (Face_Security_Required = "Y") }
        else{ (Face_Security_Required = "N") }

        if PIN_Security_Required == "Y" && PIN_Validate_At == "IDM" {
            self.createPINUpdateRequest()
        }

        /* Set UI Confuguration values */
        ImagePath_For_BankLogo = UIConfigDictionary["ImagePath_OF_BankLogo"] as? String
        ImagePath_For_SendToWallet = UIConfigDictionary["ImagePath_OF_SendToWallet"] as? String
        ImagePath_For_SendToATM = UIConfigDictionary["ImagePath_OF_SendToATM"] as? String
        ImagePath_For_History = UIConfigDictionary["ImagePath_OF_History"] as? String

        if (UIConfigDictionary["HexColor_OF_Header_Background"] as? String) == "" {
            Header_Background_Color = nil
        } else {
            Header_Background_Color = UIConfigDictionary["HexColor_OF_Header_Background"] as? String
        }

        if (UIConfigDictionary["HexColor_OF_Header_SelectedText"] as? String) == "" {
            Header_SelectedText_HexColor_String = nil
        } else {
            Header_SelectedText_HexColor_String = UIConfigDictionary["HexColor_OF_Header_SelectedText"] as? String
        }

        if (UIConfigDictionary["HexColor_OF_Header_UnSelectedText"] as? String) == "" {
            Header_UnSelectedText_HexColor_String = nil
        } else {
            Header_UnSelectedText_HexColor_String = UIConfigDictionary["HexColor_OF_Header_UnSelectedText"] as? String
        }

        if (UIConfigDictionary["HexColor_OF_AmountText"] as? String) == "" {
            Amount_Text_Color = nil
        } else {
            Amount_Text_Color = UIConfigDictionary["HexColor_OF_AmountText"] as? String
        }

        if (UIConfigDictionary["HexColor_OF_AmountBackgroundColor"] as? String) == "" {
            Amount_Background_Color = nil
        } else {
            Amount_Background_Color = UIConfigDictionary["HexColor_OF_AmountBackgroundColor"] as? String
        }

        if (UIConfigDictionary["HexColor_OF_SendBackground"] as? String) == "" {
            SendButton_Background_Color = nil
        } else {
            SendButton_Background_Color = UIConfigDictionary["HexColor_OF_SendBackground"] as? String
        }

    }

    // MARK: - Keyboard Functionality
    
    override open func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
        requestAutocompleteSuggestions()
    }
    
    override open func selectionWillChange(_ textInput: UITextInput?) {
        super.selectionWillChange(textInput)
        autocompleteToolbar.reset()
    }
    
    override open func selectionDidChange(_ textInput: UITextInput?) {
        super.selectionDidChange(textInput)
        autocompleteToolbar.reset()
    }

    // MARK: - Properties

    let alerter = ToastAlert()
    
    var keyboardType = KeyboardType.alphabetic(uppercased: true) {
        didSet { setupKeyboard() }
    }

    // MARK:Autocomplete
    lazy var autocompleteProvider = DemoAutocompleteSuggestionProvider()
    lazy var autocompleteToolbar: AutocompleteToolbar = {
        AutocompleteToolbar(textDocumentProxy: textDocumentProxy)
    }()

    // MARK:Toolbar
    lazy var toolbar: Toolbar = {
        Toolbar(textDocumentProxy: textDocumentProxy)
    }()

    // MARK:HeaderToolbar
    lazy var headerToolbar: HeaderToolbar = {
        HeaderToolbar(textDocumentProxy: textDocumentProxy)
    }()

    func headerToolbarUpdate() {
        if(amountPagar=="0.00"){
            headerToolbar.update(with: [""])
        }else{
            headerToolbar.update(with: [""])
        }
    }

    // MARK:AmountToolbar
    lazy var amountToolbar: AmountToolbar = {
        AmountToolbar(textDocumentProxy: textDocumentProxy)
    }()

    func amountToolbarUpdate() {
        if(amountPagar=="0.00"){
            amountToolbar.update(with: ["0.00"])
        }else{
            amountToolbar.update(with: [""+amountPagar])
        }
    }

    // MARK:OTPToolbar
    lazy var otpToolbar: OTPToolbar = {
        OTPToolbar(textDocumentProxy: textDocumentProxy)
    }()

    func otpToolbarUpdate() {
        if(otpString == ""){
            otpToolbar.update(with: [""])
        }else{
            otpToolbar.update(with: [otpString])
        }
    }

    // MARK:PINToolbar
    lazy var pinToolbar: PINToolbar = {
        PINToolbar(textDocumentProxy: textDocumentProxy)
    }()

    func pinToolbarUpdate() {
        if(pinString == ""){
            pinToolbar.update(with: [""])
        }else{
            pinToolbar.update(with: [pinString])
        }
    }

    // MARK:PhoneToolbar
    lazy var phoneToolbar: PhoneToolbar = {
        PhoneToolbar(textDocumentProxy: textDocumentProxy)
    }()

    func phoneToolbarUpdate() {
        if(phoneNumberString == ""){
            phoneToolbar.update(with: [""])
        }else{
            phoneToolbar.update(with: [phoneNumberString])
        }
    }
}


private extension KeyboardParentViewController {

    func createPINUpdateRequest() {
        sendPINUpdateRequest(){ (successValue) in
            if successValue {
                print("PIN Updated successfully")
            } else if !successValue {
                print("PIN Updation Failed")
            }
        }
    }

    func sendPINUpdateRequest(completion: @escaping (Bool) -> Void) {
        var stringParams =
            "<Interface>" +
               "<Customer_Interface>" +
                   "<UpdateRQ>" +
                       "<Security_Data>" +
                           "<Unique_Data>" +
                               "<Login_Data>" +
                                   "<Login_Id>" + Login_Id + "</Login_Id>" +
                                   "<Application_Code>" + Application_Code + "</Application_Code>" +
                                 "</Login_Data>" +
                             "</Unique_Data>" +
                           "<Password>" + Login_Password + "</Password>" +
                           "<Merchant_Id>" + Merchant_Id + "</Merchant_Id>" +
                           "<Application_Version>6.4.7.11</Application_Version>" +
                         "</Security_Data>" +
                       "<Customer_Data>" +
                           "<Type>" +
                               "<Person>"
        if Sender_Name != "" {
            stringParams = stringParams + "<Name>" + Sender_Name + "</Name>"
        }

        stringParams = stringParams +
                                   "<ID_Data>" +
                                       "<ID_Type>PIN</ID_Type>" +
                                       "<ID_Number>" + Customer_Security_PIN + "</ID_Number>" +
                                     "</ID_Data>" +
                                   "<Phone_Data>" +
                                       "<Type>CELL</Type>" +
                                       "<Primary>Y</Primary>" +
                                       "<Number>" + Phone_Number + "</Number>" +
                                       "<Update_Flag>UPDATE</Update_Flag>" +
                                     "</Phone_Data>" +
                                 "</Person>" +
                             "</Type>" +
                           "<CustomerCode>" + Customer_Code + "</CustomerCode>" +
                         "</Customer_Data>" +
                     "</UpdateRQ>" +
                 "</Customer_Interface>" +
             "</Interface>"

        print(stringParams)
        guard let url = URL(string:Url) else {return }
        var xmlRequest = URLRequest(url: url)
        xmlRequest.httpBody = stringParams.data(using: String.Encoding.utf8, allowLossyConversion: true)
        xmlRequest.httpMethod = "POST"
        xmlRequest.addValue("application/xml", forHTTPHeaderField: "Content-Type")

        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: xmlRequest, completionHandler: {data, response, error in

            if let data = data {
                let xml = SWXMLHash.parse(data)
                print("XML RESPONSE", xml.element!)
                let statusCode = xml["Interface"]["Customer_Interface"]["UpdateRS"]["Status_Data"]["Status_Code"].element?.text
                if statusCode == "000" {
                    completion(true)
                } else {
                    completion(false)
                }
            }else{
                completion(false)
            }

        })
        task.resume()
    }
}
