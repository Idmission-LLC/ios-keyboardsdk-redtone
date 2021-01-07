//
//  AppDelegate.swift
//  MyMoDemo
//
//  Created by MCB-Air-036 on 04/05/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Set Values for App Group
        Enable_MyMO = Credential.Enable_MyMO
        Application_Code = Credential.Application_Code
        Phone_Number = Credential.Phone_Number
        Sender_Name = Credential.Sender_Name
        Customer_Code = Credential.Customer_Code
        Country_Code = Credential.Country_Code
        Currency_Code = Credential.Currency_Code
        Login_Id = Credential.Login_Id
        Login_Password = Credential.Login_Password
        Merchant_Id = Credential.Merchant_Id
        Minimum_Amount = Credential.Minimum_Amount
        Maximum_Amount = Credential.Maximum_Amount
        Language_Code = Credential.Language_Code
        Url = Credential.Url
        Bank_Branch_Code = Credential.Bank_Branch_Code
        Bank_Account_No = Credential.Bank_Account_No
        PhoneNo_Security_Required = Credential.PhoneNo_Security_Required
        OTP_Security_Required = Credential.OTP_Security_Required
        PIN_Security_Required = Credential.PIN_Security_Required
        PIN_Validate_At = Credential.PIN_Validate_At
        Customer_Security_PIN = Credential.Customer_Security_PIN
        Email_Security_Required = Credential.Email_Security_Required
        Face_Security_Required = Credential.Face_Security_Required

        ImagePath_For_BankLogo = Credential.bankImagePath
        ImagePath_For_SendToWallet = Credential.sendToWalletImagePath
        ImagePath_For_SendToATM = Credential.sendToATMImagePath
        ImagePath_For_History = Credential.historyImagePath

        HexColor_For_Header_Background = Credential.headerBackgroundColor
        HexColor_For_Header_SelectedText = Credential.headerSelectedTextColor
        HexColor_For_Header_UnSelectedText = Credential.headerUnSelectedTextColor
        HexColor_For_AmountText = Credential.amountTextColor
        HexColor_For_AmountBackgroundColor = Credential.amountBackgroundColor
        HexColor_For_SendBackground = Credential.sendBackgroundColor

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

