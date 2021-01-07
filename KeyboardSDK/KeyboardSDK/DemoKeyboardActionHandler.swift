//
//  DemoKeyboardActionHandler.swift
//

import UIKit

/**
 
 This action handler inherits `StandardKeyboardActionHandler`
 and adds demo-specific functionality to it.
 
 */
var paymentURL=""
var paymentKeyboardOpen = false
var enterOTPKeyboardOpen = false
var enterPINKeyboardOpen = false
var enterPhoneNoKeyboardOpen = false
var amountPagar = "0.00"
var otpString = ""
var pinString = ""
var phoneNumberString = ""
var genratURLModel:GenerateURLModelResponse?

class DemoKeyboardActionHandler: StandardKeyboardActionHandler {

    // MARK: - Initialization

    public init(inputViewController: UIInputViewController) {
        keyboardShiftState = .uppercased
        super.init( inputViewController: inputViewController, hapticConfiguration: .standard)
        NotificationCenter.default.addObserver(self, selector: #selector(executeSendAction), name: .PressedSendButton, object: nil)
    }

    @objc func executeSendAction(notification: Notification) {
        if let dict = notification.userInfo as NSDictionary? {
            guard let sender = dict["Sender"] as? String else { return }
            if sender == "Send to wallet" {
                self.handleTap(on: .image(description: "Send to wallet", keyboardImageName: "Send to wallet", imageName: "Send to wallet"), view: notification.object as! UIView)
            }else if sender == "Send to ATM" {
                self.handleTap(on: .image(description: "Send to ATM", keyboardImageName: "Send to ATM", imageName: "Send to ATM"), view: notification.object as! UIView)
            }else if sender == "History" {
                self.handleTap(on: .image(description: "History", keyboardImageName: "History", imageName: "History"), view: notification.object as! UIView)
            }
        } else {
            self.handleTap(on: .character("Send"), view: notification.object as! UIView)
        }
    }

    // MARK: - Properties

    private var keyboardShiftState: KeyboardShiftState

    public var demoViewController: KeyboardParentViewController? {
        inputViewController as? KeyboardParentViewController
    }

    // MARK: - Actions

    override func longPressAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        switch action {
            case .image(_, _, let imageName): return { [weak self] in self?.saveImage(UIImage.setImageFromBundle(name: imageName)!) }
            case .backspace: return super.repeatAction(for: .backspace, view: view)
            case .character: return handleCharacterLongPress(action, for: view)
            default: return super.longPressAction(for: action, view: view)
        }
    }

    override func repeatAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        switch action {
            case .shift,.shiftDown:
                UserDefaults.standard.set(false, forKey: KeyBoardKeys.capsLocked)
                return switchToCapsLockedKeyboard
            case .backspace: return super.repeatAction(for: .backspace, view: view)
            default:
                return nil
        }
    }

    override func tapAction(for action: KeyboardAction, view: UIView) -> GestureAction? {
        switch action {
            case .character: return handleCharacter(action, for: view)
            case .image(_, _, let imageName): return imageAction(action, UIImage.setImageFromBundle(name: imageName)!, for: view)
            case .shift: return switchToUppercaseKeyboard
            case .shiftDown: return switchToLowercaseKeyboard
            case .space: return handleSpace(for: view)
            case .switchToKeyboard(let type): return { [weak self] in self?.demoViewController?.keyboardType = type }
            default: return super.tapAction(for: action, view: view)
        }
    }

    // MARK: - Action Handling

    override func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, view: UIView) {
        super.handle(gesture, on: action, view: view)
        demoViewController?.requestAutocompleteSuggestions()
    }

    override func handleRepeat(on action: KeyboardAction, view: UIView) {
        super.handle(.repeatPress, on: action, view: view)
    }
}


// MARK: - Image Functions

@objc extension DemoKeyboardActionHandler {

    func handleImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil { alert("Saved!") }
        else { alert("Failed!") }
    }
}


// MARK: - Actions

private extension DemoKeyboardActionHandler {

    func alert(_ message: String) {
        guard let input = inputViewController as? KeyboardParentViewController else { return }
        input.alerter.alert(message: message, in: input.view, withDuration: 5)
    }

    func showProcessingView(boolValue:Bool) {
        demoViewController?.alerter.processingView(showSpinner: boolValue, in: demoViewController!.view)
    }

    func copyImage(_ image: UIImage) {
        guard let input = inputViewController as? KeyboardParentViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to copy images.") }
        guard image.copyToPasteboard() else { return alert("The image could not be copied.") }
        alert("Copied to pasteboard!")
    }

    func saveImage(_ image: UIImage) {
        guard let input = inputViewController as? KeyboardParentViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to save images to photos.") }
        let saveCompletion = #selector(handleImage(_:didFinishSavingWithError:contextInfo:))
        image.saveToPhotos(completionTarget: self, completionSelector: saveCompletion)
    }

    func handleSpace(for view: UIView) -> GestureAction {
        let baseAction = super.tapAction(for: .space, view: view)
        return { [weak self] in
            baseAction?()
            let isNonAlpha = self?.demoViewController?.keyboardType != .alphabetic(uppercased: false)
            guard isNonAlpha else { return }
        }
    }

    // MARK:- set keyboard type

    func imageAction(_ action: KeyboardAction, _ image: UIImage, for view: UIView) -> GestureAction {
        var type: KeyboardType = .alphabetic(uppercased: true)
        let baseAction = super.tapAction(for: action.returnEmpty(), view: view)

        if(action.getImageDescription=="Send to wallet") {
            type = .images
            return { [weak self] in self?.demoViewController?.keyboardType = type}
        } else {
            alert("Not Available")
            return { baseAction?() }
        }
    }
    
    func handleCharacterLongPress(_ action: KeyboardAction, for view: UIView) -> GestureAction {
        var selctedString = ""
        if let selectedCharacter = UserDefaults.standard.object(forKey: "SelectedCharString") {
            UserDefaults.standard.set(nil, forKey: "SelectedCharString")
            selctedString = selectedCharacter as! String
        }
        let baseAction = super.tapAction(for: .character(selctedString), view: view)
        return { [weak self] in
            baseAction?()
            let isUppercased = self?.keyboardShiftState == .uppercased
            guard isUppercased else { return }
            self?.switchToAlphabeticKeyboard(.lowercased)
        }
    }

    func handleCharacter(_ action: KeyboardAction, for view: UIView) -> GestureAction {
        var baseAction = super.tapAction(for: action, view: view)
        if action.isHistory {
            alert("Not Available")
            baseAction = super.tapAction(for: action.returnEmpty(), view: view)
        } else if action.isSend {
            return self.handleSend_Key_Action(action: action, for: view)
        } else if paymentKeyboardOpen && !enterOTPKeyboardOpen && !enterPINKeyboardOpen && !enterPhoneNoKeyboardOpen {
            self.update_AmountLabel_Value(action: action)
            demoViewController?.amountToolbarUpdate()
            baseAction = super.tapAction(for: action.returnEmpty(), view: view)
        } else if !paymentKeyboardOpen && enterOTPKeyboardOpen && !enterPINKeyboardOpen && !enterPhoneNoKeyboardOpen {
            self.update_OTPTextField_Value(action: action)
            demoViewController?.otpToolbarUpdate()
            baseAction = super.tapAction(for: action.returnEmpty(), view: view)
        } else if !paymentKeyboardOpen && !enterOTPKeyboardOpen && enterPINKeyboardOpen && !enterPhoneNoKeyboardOpen {
            self.update_PINTextField_Value(action: action)
            demoViewController?.pinToolbarUpdate()
            baseAction = super.tapAction(for: action.returnEmpty(), view: view)
        } else if !paymentKeyboardOpen && !enterOTPKeyboardOpen && !enterPINKeyboardOpen && enterPhoneNoKeyboardOpen {
            self.update_PhoneTextField_Value(action: action)
            demoViewController?.phoneToolbarUpdate()
            baseAction = super.tapAction(for: action.returnEmpty(), view: view)
        }

        return { [weak self] in
            baseAction?()
            let isUppercased = self?.keyboardShiftState == .uppercased
            guard isUppercased else { return }
            //            self?.switchToAlphabeticKeyboard(.lowercased)
        }
    }

    func handleSend_Key_Action(action: KeyboardAction, for view: UIView) -> GestureAction {
        var baseAction = super.tapAction(for: action, view: view)

        switch self.demoViewController?.keyboardType {
            case .images:
                let minValue = Float(Minimum_Amount) ?? 0.0
                let maxValue = Float(Maximum_Amount) ?? 0.0
                let selectedAmount = Float(amountPagar) ?? 0.0

                if(amountPagar=="0.00"){

                    alert("Please enter amount")
                    baseAction = super.tapAction(for: action.returnEmpty(), view: view)

                } else if ( selectedAmount > maxValue ) {

                    alert("Amount should be less than max value")
                    baseAction = super.tapAction(for: action.returnEmpty(), view: view)

                } else if (selectedAmount < minValue ) {

                    alert("Amount should be greater than min value")
                    baseAction = super.tapAction(for: action.returnEmpty(), view: view)

                } else if OTP_Security_Required == "Y" {

                    print("Send_OTP_APICall")
                    baseAction = super.tapAction(for: action.returnEmpty(), view: view)
                    self.createOTPRequest(action: action, for: view)
                    return { [weak self] in self?.demoViewController?.keyboardType = .custom("OTPTypeKeyboard")}

                } else if PIN_Security_Required == "Y" {

                    return { [weak self] in self?.demoViewController?.keyboardType = .custom("PINTypeKeyboard")}

                } else if PhoneNo_Security_Required == "Y" {

                    return { [weak self] in self?.demoViewController?.keyboardType = .custom("PhonNumberTypeKeyboard")}

                } else {

                    print("Send_Payment_APICall")
                    baseAction = super.tapAction(for: action.returnEmpty(), view: view)
                    self.createPaymentRequest(action: action, for: view)

            }
            case .custom("OTPTypeKeyboard"):

                if(otpString==""){

                    alert("Please enter OTP")
                    baseAction = super.tapAction(for: action.returnEmpty(), view: view)

                } else if PhoneNo_Security_Required == "Y" {

                    return { [weak self] in self?.demoViewController?.keyboardType = .custom("PhonNumberTypeKeyboard")}

                } else {

                    print("Send_Payment_APICall")
                    baseAction = super.tapAction(for: action.returnEmpty(), view: view)
                    self.createPaymentRequest(action: action, for: view)
                    
            }
            case .custom("PINTypeKeyboard"):

                if(pinString==""){

                    alert("Please enter PIN")
                    baseAction = super.tapAction(for: action.returnEmpty(), view: view)

                } else if PhoneNo_Security_Required == "Y" {

                    return { [weak self] in self?.demoViewController?.keyboardType = .custom("PhonNumberTypeKeyboard")}

                } else {

                    print("Send_Payment_APICall")
                    baseAction = super.tapAction(for: action.returnEmpty(), view: view)
                    self.createPaymentRequest(action: action, for: view)

            }
            case .custom("PhonNumberTypeKeyboard"):

                if(phoneNumberString==""){

                    alert("Please enter Phone Number")
                    baseAction = super.tapAction(for: action.returnEmpty(), view: view)

                } else {

                    print("Send_Payment_APICall")
                    baseAction = super.tapAction(for: action.returnEmpty(), view: view)
                    self.createPaymentRequest(action: action, for: view)

            }

            case .none: break
            case .some(.alphabetic( _)): break
            case .some(.numeric): break
            case .some(.symbolic): break
            case .some(.email): break
            case .some(.emojis): break
            case .some(.custom(_)): break
        }

        return { baseAction?() }
    }

    func switchToCapsLockedKeyboard() {
        if UserDefaults.standard.bool(forKey: KeyBoardKeys.capsLocked){
            switchToAlphabeticKeyboard( .uppercased)
        }else{
            UserDefaults.standard.set(true, forKey:KeyBoardKeys.capsLocked )
            switchToAlphabeticKeyboard(.capsLocked)
        }
    }

    func switchToLowercaseKeyboard() {
        switchToAlphabeticKeyboard(.lowercased)
    }

    func switchToUppercaseKeyboard() {
        UserDefaults.standard.set(false, forKey: KeyBoardKeys.capsLocked)
        switchToAlphabeticKeyboard( .uppercased)
    }

    func switchToAlphabeticKeyboard(_ state: KeyboardShiftState) {
        keyboardShiftState = state
        demoViewController?.keyboardType = .alphabetic(uppercased: state.isUppercased)
    }
}


//MARK:- Extension To handle Toolbar value
extension DemoKeyboardActionHandler {

    func update_AmountLabel_Value(action: KeyboardAction) {
        let numVal = action.getNumberString
        let t0 = Double(amountPagar)!
        let t1 = Int(t0*100)
        let t2 = String(t1)
        if(numVal=="C"){
            amountPagar = "0.00"
        } else if(numVal=="-"){
            if(t2.count==1){
                amountPagar = "0.00"
            } else if(t2.count>1){
                let t3 = String(t2)
                let t4 = t3.dropLast()
                var t5 = Double(t4)!
                t5 = t5/100
                amountPagar = String(t5)
                let amountPagarArr = amountPagar.components(separatedBy: ".")
                let afterDecimal: String! = amountPagarArr.count > 1 ? amountPagarArr[1] : nil
                if(afterDecimal.count==1){
                    amountPagar = amountPagar + "0"
                }
            }
        } else if(t2.count<9){
            if(amountPagar=="0.00"){
                amountPagar = "0.0"+numVal
            } else{
                var t0 = Double(amountPagar)
                t0 = t0! * 100
                let t1 = Int(t0!)
                let t2 = String(t1)
                if(t2.count==1) {
                    amountPagar = "0." + t2 + numVal
                } else if(t2.count>1) {
                    let t3 = t2 + numVal
                    var t4 = Double(t3)!;
                    t4 = t4/100
                    amountPagar = String(t4)
                    let amountPagarArr = amountPagar.components(separatedBy: ".")
                    let afterDecimal: String! = amountPagarArr.count > 1 ? amountPagarArr[1] : nil
                    if(afterDecimal.count==1) {
                        amountPagar = amountPagar + "0"
                    }
                }
            }
        }
    }

    func update_OTPTextField_Value(action: KeyboardAction) {
        let numVal = action.getNumberString
        if(numVal=="C"){
            otpString = ""
        } else if(numVal=="-"){
            if(otpString.count==1){
                otpString = ""
            } else if(otpString.count>1){
                otpString = String(otpString.dropLast())
            }
        } else if(otpString.count < 20){
            if(otpString == ""){
                otpString = numVal
            } else{
                otpString = otpString + numVal
            }
        }
    }

    func update_PINTextField_Value(action: KeyboardAction) {
        let numVal = action.getNumberString
        if(numVal=="C"){
            pinString = ""
        } else if(numVal=="-"){
            if(pinString.count==1){
                pinString = ""
            } else if(pinString.count>1){
                pinString = String(pinString.dropLast())
            }
        } else if(pinString.count < 20){
            if(pinString == ""){
                pinString = numVal
            } else{
                pinString = pinString + numVal
            }
        }
    }

    func update_PhoneTextField_Value(action: KeyboardAction) {
        let numVal = action.getNumberString
        if(numVal=="C"){
            phoneNumberString = ""
        } else if(numVal=="-"){
            if(phoneNumberString.count==1){
                phoneNumberString = ""
            } else if(phoneNumberString.count>1){
                phoneNumberString = String(phoneNumberString.dropLast())
            }
        } else if(phoneNumberString.count < 20){
            if(phoneNumberString == ""){
                phoneNumberString = numVal
            } else{
                phoneNumberString = phoneNumberString + numVal
            }

        }

    }
}


//MARK:- Extension To handle API Calls
extension DemoKeyboardActionHandler {

    func createOTPRequest(action: KeyboardAction, for view: UIView) {
        sendOTPRequest(){ (successValue) in
            if successValue {
                print("OTP sent successfully")
            } else if !successValue {
                print("OTP sent Failed")
                DispatchQueue.main.async {
                    self.alert("Generate OTP Failed...")
                }
            }
        }
    }

    func sendOTPRequest(completion: @escaping (Bool) -> Void) {
        let stringParams =
            "<Interface>" +
                "<Customer_Interface>" +
                "<GenerateOtpRQ>" +
                "<Security_Data>" +
                "<Unique_Data>" +
                "<Login_Data>" +
                "<Login_Id>" + Login_Id + "</Login_Id>" +
                "<Application_Code>CUX</Application_Code>" +
                "</Login_Data>" +
                "</Unique_Data>" +
                "<Password>" + Login_Password + "</Password>" +
                "<Merchant_Id>" + Merchant_Id + "</Merchant_Id>" +
                "<Application_Version>6.4.7.11</Application_Version>" +
                "</Security_Data>" +
                "<Customer_Data>" +
                "<Type>" +
                "<Person>" +
                "<Phone_Data>" +
                "<Number>" + Phone_Number + "</Number>" +
                "</Phone_Data>" +
                "</Person>" +
                "</Type>" +
                "</Customer_Data>" +
                "<Otp_For>IDS</Otp_For>" +
                "<Customer_Locale>" + Language_Code + "</Customer_Locale>" +
                "</GenerateOtpRQ>" +
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
                let statusCode = xml["Interface"]["Customer_Interface"]["GenerateOtpRS"]["Status_Data"]["Status_Code"].element?.text
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

    func createPaymentRequest(action: KeyboardAction, for view: UIView) {

        showProcessingView(boolValue: true)
        sendPaymentRequest(amount: String(amountPagar)){ (data, success) in
            DispatchQueue.main.async {
                self.showProcessingView(boolValue: false)
                if !success {
                    self.alert("Transaction Failed...")
                } else if success {
                    self.alert("You sent: $" + amountPagar)
                }

                Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { timer in
                    let baseAction = super.tapAction(for: action.pressSpecialCharacter(Amount: String(amountPagar), ResponseURLString: data), view: view)
                    baseAction?()
                    self.demoViewController?.keyboardType = .images
                }

            }
        }
    }

    func sendPaymentRequest(amount: String, completion: @escaping (String ,Bool) -> Void) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let timeStamp: String = formatter.string(from: date);
        var paymentURL="0"

        var stringParams : String = "<Interface>" +
            "<Transaction_Interface>" +
            "<SaleRQ>" +
            "<Security_Data>" +
            "<Unique_Data>" +
            "<Login_Data>" +
            "<Login_Id>" + Login_Id + "</Login_Id>" +
            "<Application_Code>CUX</Application_Code>" +
            "</Login_Data>" +
            "</Unique_Data>" +
            "<Password>" + Login_Password + "</Password>" +
            "<Merchant_Id>" + Merchant_Id + "</Merchant_Id>" +
            "<Application_Version>6.4.7.11</Application_Version>" +
            "</Security_Data>" +
            "<Transaction_Data>" +
            "<Type>TRANSFER</Type>" +
            "<TimeStamp>" + timeStamp + "</TimeStamp>" +
            "<Amount>" + amount + "</Amount>" +
            "<CurrencyCode>" + Currency_Code + "</CurrencyCode>" +
            "<CountryCode>" + Country_Code + "</CountryCode>" +
            "<Transaction_Status>Pending</Transaction_Status>" +
            "<Transaction_Process_Verified>Y</Transaction_Process_Verified>" +
        "<Generate_Payment_URL>Y</Generate_Payment_URL>"

        if PIN_Security_Required == "Y" && PIN_Validate_At != "" {
            stringParams = stringParams + "<Validate_Pin_At>" + PIN_Validate_At + "</Validate_Pin_At>"
        }

        stringParams = stringParams +
            "</Transaction_Data>" +
            "<Location_Data>" +
            "<Device_Id>968a16b207888ca0</Device_Id>" +
            "<Merchant_Id>" + Merchant_Id + "</Merchant_Id>" +
            "</Location_Data>" +
            "<Customer_Data>" +
            "<Type>" +
        "<Person>"

        if Sender_Name != "" {
            stringParams = stringParams + "<Name>" + Sender_Name + "</Name>"
        }

        stringParams = stringParams +
            "<Phone_Data>" +
            "<Number>" + Phone_Number + "</Number>" +
            "</Phone_Data>" +
            "</Person>" +
            "</Type>" +
            "<Customer_Preferred_Language_locale>" + Language_Code + "</Customer_Preferred_Language_locale>"

        if Customer_Code != "" {
            stringParams = stringParams + "<CustomerCode>" + Customer_Code + "</CustomerCode>"
        }

        if Bank_Branch_Code != "" {
            if Bank_Branch_Code == "IDM_WALLET" {
                stringParams = stringParams +
                    "<Financial_Data>" +
                    "<Bank_Account_Data>" +
                    "<Bank_Code>" + Bank_Branch_Code + "</Bank_Code>" +
                    "</Bank_Account_Data>" +
                "</Financial_Data>"

            } else {
                stringParams = stringParams +
                    "<Financial_Data>" +
                    "<Bank_Account_Data>" +
                    "<Account_Number>" + Bank_Account_No + "</Account_Number>" +
                    "<Bank_Code>" + Bank_Branch_Code + "</Bank_Code>" +
                    "</Bank_Account_Data>" +
                "</Financial_Data>"
            }
        }

        if OTP_Security_Required == "Y" {
            stringParams = stringParams +
                "<Transaction_Security>" +
                "<Start_Amount>0.0</Start_Amount>" +
                "<Security_Type>" +
                "<Level_Type>IDS_OTP</Level_Type>" +
                "<Level_Data>" + otpString + "</Level_Data>" +
                "</Security_Type>" +
            "</Transaction_Security>"
        } else if PIN_Security_Required == "Y" {
            stringParams = stringParams +
                "<Transaction_Security>" +
                "<Start_Amount>0.0</Start_Amount>" +
                "<Security_Type>" +
                "<Level_Type>PIN</Level_Type>" +
                "<Level_Data>" + pinString + "</Level_Data>" +
                "</Security_Type>" +
            "</Transaction_Security>"
        }

        stringParams = stringParams + "</Customer_Data>"

        if PhoneNo_Security_Required == "Y" {
            stringParams = stringParams +
                "<Receiver_Data>" +
                "<Receiver_Phone_Number>" + phoneNumberString + "</Receiver_Phone_Number>" +
                "<Amount>" + amount + "</Amount>" +
            "</Receiver_Data>"
        }

        stringParams = stringParams +
            "</SaleRQ>" +
            "</Transaction_Interface>" +
        "</Interface>"

        print(stringParams)
        guard let url = URL(string:Url) else {return }
        var xmlRequest = URLRequest(url: url)
        xmlRequest.httpBody = stringParams.data(using: String.Encoding.utf8, allowLossyConversion: true)
        xmlRequest.httpMethod = "POST"
        xmlRequest.addValue("application/xml", forHTTPHeaderField: "Content-Type")

        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: xmlRequest, completionHandler: {data, response, error in
            if let responseData = data {
                guard let responseString = String(data: responseData, encoding: .utf8) else {return}
                let datadec  = responseString.data(using: String.Encoding.utf8)
                guard let decodevalue = String(data: datadec!, encoding: String.Encoding.nonLossyASCII) else {return}

                let xml = SWXMLHash.parse(decodevalue)
                print("XML_RESPONSE", xml.element!)
                let statusCode = xml["Interface"]["Transaction_Interface"]["SaleRS"]["Status_Data"]["Status_Code"].element?.text
                if statusCode == "000" {
                    paymentURL = xml["Interface"]["Transaction_Interface"]["SaleRS"]["Transaction_Response_Parameter"][0]["Parameter_Value"].element!.text
                    guard let stringToJoin = xml["Interface"]["Transaction_Interface"]["SaleRS"]["Transaction_Response_Parameter"][1]["Parameter_Value"].element?.text else {
                        completion(paymentURL, true)
                        return
                    }
                    paymentURL = stringToJoin.appending("\n".appending(paymentURL))
                    print("paymentURL", paymentURL)
                    completion(paymentURL, true)
                } else {
                    completion("",false)
                }
            }else{
                completion("",false)
            }

        })
        task.resume()

    }
}

extension Notification.Name {
    static let PressedSendButton = Notification.Name("PressedSendButton")
    static let PressedResetButton = Notification.Name("PressedResetButton")
}
