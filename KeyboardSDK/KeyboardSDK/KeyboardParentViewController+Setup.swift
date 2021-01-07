//
//  KeyboardParentViewController+Setup.swift
//

//import KeyboardKit
import UIKit

extension KeyboardParentViewController {
    
    func setupKeyboard() {
        setupKeyboard(for: self.view.bounds.size)
    }
    
    func setupKeyboard(for size: CGSize) {
        DispatchQueue.main.async {
            self.setupKeyboardAsync(for: size)
        }
    }

    func resetToolbarOpenFlag() {
        paymentKeyboardOpen=false
        enterOTPKeyboardOpen = false
        enterPINKeyboardOpen = false
        enterPhoneNoKeyboardOpen = false
    }

    func resetToolbarValueToDefault() {
        amountPagar = "0.00"
        otpString = ""
        pinString = ""
        phoneNumberString = ""
    }

    func setupKeyboardAsync(for size: CGSize) {
        keyboardStackView.removeFromSuperview()
        keyboardStackView.removeAllArrangedSubviews()
        resetToolbarOpenFlag()

        super.viewDidLoad()
        switch keyboardType {
            case .alphabetic(let uppercased): setupAlphabeticKeyboard(uppercased: uppercased)
            case .emojis: setupEmojiKeyboard(for: size)
            case .images: setupPaymentKeyboard()
            case .numeric: setupNumericKeyboard()
            case .symbolic: setupSymbolicKeyboard()
            case .custom("OTPTypeKeyboard"): setupEnterOTPKeyboard()
            case .custom("PINTypeKeyboard"): setupEnterPINKeyboard()
            case .custom("PhonNumberTypeKeyboard"): setupEnterPhonNumberKeyboard()
            default: return
        }
    }

    //MARK:- Default Keyboard

    func setupAlphabeticKeyboard(uppercased: Bool = false) {
        resetToolbarValueToDefault()
        NotificationCenter.default.post(name: .PressedResetButton, object: self, userInfo: nil)

        let keyboard = AlphabeticKeyboard(uppercased: uppercased, in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }

    func setupEmojiKeyboard(for size: CGSize) {
        let keyboard = EmojiKeyboard(in: self)
        let isLandscape = size.width > 400
        let rowsPerPage = isLandscape ? 4 : 5
        let buttonsPerRow = isLandscape ? 10 : 8
        let config = KeyboardButtonRowCollectionView.Configuration(rowHeight: 40, rowsPerPage: rowsPerPage, buttonsPerRow: buttonsPerRow)
        let view = KeyboardButtonRowCollectionView(actions: keyboard.actions, configuration: config) { [unowned self] in return self.button(for: $0) }
        let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubview(view)
        keyboardStackView.addArrangedSubview(bottom)
    }

    func setupImageKeyboard(for size: CGSize) {
        let keyboard = ImageKeyboard(in: self)
        let config = KeyboardButtonRowCollectionView.Configuration(rowHeight: 150, rowsPerPage: 1, buttonsPerRow: 1)
        let view = KeyboardButtonRowCollectionView(actions: keyboard.actions, configuration: config) { [unowned self] in return self.button(for: $0) }
        let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubview(view)
        keyboardStackView.addArrangedSubview(bottom)
    }

    func setupNumericKeyboard() {
        let keyboard = NumericKeyboard(in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }

    func setupSymbolicKeyboard() {
        let keyboard = SymbolicKeyboard(in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }

    //MARK:- Send-To-Wallet Keyboard
    func setupPaymentKeyboard() {
        resetToolbarValueToDefault()
        paymentKeyboardOpen=true
        self.amountToolbarUpdate()

        let paymentKeyboard = PaymentNumericKeyboard(in: self)
        let rows = buttonRows(for: paymentKeyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }

    func setupEnterOTPKeyboard() {
        enterOTPKeyboardOpen = true
        let keyboard = PaymentNumericKeyboard(in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }

    func setupEnterPINKeyboard() {
        enterPINKeyboardOpen = true
        let keyboard = PaymentNumericKeyboard(in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }

    func setupEnterPhonNumberKeyboard() {
        enterPhoneNoKeyboardOpen = true
        let keyboard = PaymentNumericKeyboard(in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }
}
