//
//  Extensions.swift
//  MyMoDemo
//
//  Created by MCB-Air-036 on 21/05/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {

    func getSharedURL_FilePath(forImage imageName: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.idmission.MyMoDemo") else { return nil }
        return documentURL.appendingPathComponent(imageName + ".png")
    }

    func storeImageFile(filename:String, imagePNGdata:Data) {
        guard let url = self.getSharedURL_FilePath(forImage: filename) else { return }

        // Write file to Group Container
        let fileManager = FileManager.default
        fileManager.createFile(atPath: url.path as String, contents: imagePNGdata, attributes: nil)

        if filename == "BankLogo" {
            ImagePath_For_BankLogo = url.absoluteString
        } else if filename == "SendToWallet" {
            ImagePath_For_SendToWallet = url.absoluteString
        } else if filename == "SendToATM" {
            ImagePath_For_SendToATM = url.absoluteString
        } else if filename == "History" {
            ImagePath_For_History = url.absoluteString
        }

        //        if !fileManager.fileExists(atPath: url.path) {
        //            fileManager.createFile(atPath: url.path as String, contents: imagePNGdata, attributes: nil)
        //
        //            if filename == "BankLogo" {
        //                ImagePath_For_BankLogo = url.absoluteString
        //            } else if filename == "SendToWallet" {
        //                ImagePath_For_SendToWallet = url.absoluteString
        //            } else if filename == "SendToATM" {
        //                ImagePath_For_SendToATM = url.absoluteString
        //            } else if filename == "History" {
        //                ImagePath_For_History = url.absoluteString
        //            }
        //
        //        }
    }

    func getImageFile(sharedUrlPath:String) -> UIImage? {
        guard let url = URL(string: sharedUrlPath) else { return  nil}

        // Read file from Group Container
        let fileManager = FileManager.default
        let fileData = fileManager.contents(atPath: url.path)
        let image = UIImage(data: fileData!)
        return image

    }

}



extension InputTableViewCell : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func textFieldDidChange(_ textField: UITextField) {

        if textField.placeholder == PlaceHolder.PhoneTextfield {
            Phone_Number = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.SenderTextfield {
            Sender_Name = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.CustomerCodeTextfield {
            Customer_Code = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.CountryCodeTextfield {
            Country_Code = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.CurrencyCodeTextfield {
            Currency_Code = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.LoginIdTextfield {
            Login_Id = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.PasswordTextfield {
            Login_Password = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.MerchantIdTextfield {
            Merchant_Id = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.MinAmountTextfield {
            Minimum_Amount = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.MaxAmountTextfield {
            Maximum_Amount = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.LanguageTextfield {
            Language_Code = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.BranchCodeTextfield {
            Bank_Branch_Code = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.BankAccountTextfield {
            Bank_Account_No = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.OtpSecurityTextfield {
            OTP_Security_Required = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.PinSecurityTextfield {
            PIN_Security_Required = textField.text ?? ""
        }
        if textField.placeholder == PlaceHolder.CustomerPinTextfield {
            Customer_Security_PIN = textField.text ?? ""
        }
    }

}

extension UIConfigurationTableViewCell : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func textFieldDidChange(_ textField: UITextField) {

        if textField.placeholder == PlaceHolder.HeaderBackgroundColor {
            HexColor_For_Header_Background = textField.text ?? ""
        }

        if textField.placeholder == PlaceHolder.HeaderSelectedColor {
            HexColor_For_Header_SelectedText = textField.text ?? ""
        }

        if textField.placeholder == PlaceHolder.HeaderUnselectedColor {
            HexColor_For_Header_UnSelectedText = textField.text ?? ""
        }

        if textField.placeholder == PlaceHolder.AmountTextColor {
            HexColor_For_AmountText = textField.text ?? ""
        }

        if textField.placeholder == PlaceHolder.AmountBackgroundColor {
            HexColor_For_AmountBackgroundColor = textField.text ?? ""
        }

        if textField.placeholder == PlaceHolder.SendButtonBackgroundColor {
            HexColor_For_SendBackground = textField.text ?? ""
        }
    }

}

extension UIButton {
    func underlineText(bool:Bool) {
        guard let title = title(for: .normal) else { return }

        if bool {
            let titleString = NSMutableAttributedString(string: title)
            titleString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
            setAttributedTitle(titleString, for: .normal)
        } else {
            let titleString = NSMutableAttributedString(string: title)
            setAttributedTitle(titleString, for: .normal)

        }
    }
}

extension UIImage {

    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }

    func getSizeIn(_ type: DataUnits)-> String {

        guard let data = self.pngData() else {
            return ""
        }

        var size: Double = 0.0

        switch type {
            case .byte:
                size = Double(data.count)
            case .kilobyte:
                size = Double(data.count) / 1024
            case .megabyte:
                size = Double(data.count) / 1024 / 1024
            case .gigabyte:
                size = Double(data.count) / 1024 / 1024 / 1024
        }

        return String(format: "%.2f", size)
    }

    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }

    /**
     Create a resized copy of the image, using a new height.

     This operation will preserve the original aspect ratio.
     */
    func resized(toHeight points: CGFloat) -> UIImage? {
        let height = points * scale
        let ratio = height / size.height
        let width = size.width * ratio
        let newSize = CGSize(width: width, height: height)
        return resized(to: newSize)
    }

    /**
     Create a resized copy of the image, using a new width.

     This operation will preserve the original aspect ratio.
     */
    func resized(toWidth points: CGFloat) -> UIImage? {
        let width = points * scale
        let ratio = width / size.width
        let height = size.height * ratio
        let newSize = CGSize(width: width, height: height)
        return resized(to: newSize)
    }

    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInMb:Int) -> UIImage? {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }

        if let data = imgData {
            if (data.count < sizeInBytes) {
                return UIImage(data: data)
            }
        }
        return nil
    }

    func resizeByByte(maxByte: Int, completion: @escaping (Data) -> Void) {
        var compressQuality: CGFloat = 1
        var imageData = Data()
        var imageByte = self.jpegData(compressionQuality: 1)?.count

        while imageByte! > maxByte {
            imageData = self.jpegData(compressionQuality: compressQuality)!
            imageByte = self.jpegData(compressionQuality: compressQuality)?.count
            compressQuality -= 0.1
        }

        if maxByte > imageByte! {
            completion(imageData)
        } else {
            completion(self.jpegData(compressionQuality: 1)!)
        }
    }
}
