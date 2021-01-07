//
//  ViewController.swift
//  MyMoDemo
//
//  Created by MCB-Air-036 on 04/05/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTableView: UITableView!
    @IBOutlet var tableViewBottomConstraint: NSLayoutConstraint?

    var imagePicker = UIImagePickerController()

    var displayArray = [String]()
    var selectedIndex = 0
    var imageNameKey = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.reloadInputTableview_With_SecurityType(securityMode: .NoSecurity)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillShow(notification:)), name:  UIResponder.keyboardWillShowNotification, object: nil )
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow( notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            var newHeight: CGFloat
            let duration:TimeInterval = (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if #available(iOS 11.0, *) {
                newHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
            } else {
                newHeight = keyboardFrame.cgRectValue.height
            }
            let keyboardHeight = newHeight  + 10 // **10 is bottom margin of View**  and **this newHeight will be keyboard height**
            UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: {
                self.tableViewBottomConstraint?.constant = -keyboardHeight
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        self.tableViewBottomConstraint?.constant = 5
    }
}

// MARK:- UIImagePickerController Delegate Methods

extension ViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            var selectedImage = pickedImage
            selectedImage = selectedImage.resized(to: CGSize(width: 36, height: 36))!
            if let pngRepresentation = selectedImage.pngData() {
                self.storeImageFile(filename: imageNameKey, imagePNGdata: pngRepresentation)
            }

            self.inputTableView.reloadData()

        }

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
}

// MARK:- viewControllerDelegate Methods
extension ViewController : viewControllerDelegate {
    func getImage(forName name: String) -> UIImage {
//        return self.getImageFromPath(imagePath: name) ?? UIImage()

        return self.getImageFile(sharedUrlPath: name) ?? UIImage(named: "placeholder")!
    }

    func setImage(forName name:String) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imageNameKey = name
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func reloadInputTableview_With_SecurityType(securityMode: SecurityType) {
        switch securityMode {
            case .NoSecurity:
                displayArray = arrayType.default_Array
                selectedIndex = 0
                OTP_Security_Required = "N"
                PIN_Security_Required = "N"
                PIN_Validate_At = ""
                Customer_Security_PIN = ""

                self.inputTableView.reloadData()

            case .OTPSecurity:
                displayArray = arrayType.OTP_Security_Array
                selectedIndex = 1
                OTP_Security_Required = "Y"
                PIN_Security_Required = "N"
                PIN_Validate_At = ""
                Customer_Security_PIN = ""

                self.inputTableView.reloadData()
                let endIndexpath = IndexPath(row: displayArray.count-1, section: 0)
                self.inputTableView.scrollToRow(at: endIndexpath, at: .bottom, animated: true)

            case .PINSecurity:
                displayArray = arrayType.PIN_Security_Array
                selectedIndex = 2
                OTP_Security_Required = "N"
                PIN_Security_Required = "Y"
                PIN_Validate_At = "IDM"
                Customer_Security_PIN = ""

                self.inputTableView.reloadData()
                let endIndexpath = IndexPath(row: displayArray.count-1, section: 0)
                self.inputTableView.scrollToRow(at: endIndexpath, at: .bottom, animated: true)
        }
    }

    func reloadInputTableview_WithFocus(flag:Bool) {
        self.inputTableView.reloadData()

        if flag {
            let indexpath = IndexPath(row: 4, section: 0)
            let tableViewCell = inputTableView.cellForRow(at: indexpath) as! InputTableViewCell
            tableViewCell.inputTextField.becomeFirstResponder()
        }
    }

    func showAlertWith(titleString:String, messageString:String) {
        let alert = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}

// MARK:- UITableView Delegate Methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return displayArray.count
        } else {
            return hearderTypeArray.headingTextArray2.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {

            let Cell = tableView.dequeueReusableCell(withIdentifier: "InputCellIdentifier", for: indexPath) as! InputTableViewCell
            Cell.delegate = self
            Cell.setData(textString: displayArray[indexPath.row],
                         placeholderString: getPlaceholderTextFor(rawValue: displayArray[indexPath.row])?.DisplayString ?? "",
                         indexpath: indexPath,
                         selectedSegment: selectedIndex)
            return Cell

        } else {

            let Cell = tableView.dequeueReusableCell(withIdentifier: "UIConfigurationCellIdentifier", for: indexPath) as! UIConfigurationTableViewCell
            Cell.delegate = self

            let textstr = arrayType.UIConfig_Default_Array[indexPath.row]

            let headerstr = hearderTypeArray.headingTextArray2[indexPath.row]

            var placeholderstr = hearderTypeArray.headingTextArray2[indexPath.row].replacingOccurrences(of: " ", with: "_")
            placeholderstr = placeholderstr.replacingOccurrences(of: "-", with: "_")
            placeholderstr = getPlaceholderTextFor(rawValue: placeholderstr)?.DisplayString ?? ""

            Cell.setData(textString: textstr, headingText: headerstr, placeholderString: placeholderstr, indexpath: indexPath)
            return Cell

        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()

        if indexPath.section == 0 {
            if indexPath.row == 0 || indexPath.row == 1 ||  indexPath.row == 2 {
                cellHeight = 40
            } else if hearderTypeArray.headingTextArray1[indexPath.row] == "" {
                cellHeight = 60
            }
            else {
                cellHeight = 75
            }
        } else {
            if hearderTypeArray.headingTextArray2[indexPath.row].contains("Choose") {
                cellHeight = 60
            } else {
                cellHeight = 75
            }
        }
        return cellHeight
    }
}
