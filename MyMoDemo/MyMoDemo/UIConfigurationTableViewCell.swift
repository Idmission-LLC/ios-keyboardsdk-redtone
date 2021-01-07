//
//  UIConfigurationTableViewCell.swift
//  MyMoDemo
//
//  Created by MCB-Air-036 on 08/06/20.
//  Copyright © 2020 Idmission. All rights reserved.
//

import UIKit

class UIConfigurationTableViewCell: UITableViewCell {

    //MARK:- Cell Properties
    @IBOutlet weak var imageSelectionView: UIView!
    @IBOutlet weak var imageSelectionButton: UIButton!
    @IBOutlet weak var imageCapturedview: UIImageView!

    @IBOutlet weak var colorSelectionView: UIView!
    @IBOutlet weak var colorConfigLabel: UILabel!
    @IBOutlet weak var colorConfigTextField: UITextField!

    weak var delegate: viewControllerDelegate?

    //MARK:- Cell Default Method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        colorConfigTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    //MARK:- Cell Data Set
    func setData(textString:String, headingText:String, placeholderString: String, indexpath:IndexPath) {
        if headingText.contains("Choose") {
            self.imageSelectionView.isHidden = false
            self.colorSelectionView.isHidden = true
            self.imageSelectionButton.tag = indexpath.row+1

            self.imageSelectionButton.setTitle(headingText, for: .normal)
            if let image = delegate?.getImage(forName: userDefaults?.string(forKey: textString) ?? ""){
                imageCapturedview.image = image
            }
        } else {
            self.imageSelectionView.isHidden = true
            self.colorSelectionView.isHidden = false

            colorConfigLabel.text = headingText
            colorConfigTextField.text = userDefaults?.string(forKey: textString) ?? ""
            colorConfigTextField.placeholder = placeholderString
        }
    }

    //MARK:- Button Action
    @IBAction func ImageChoose_ButtonAction(_ sender:UIButton) {
        print("Button_Pressed_At_Index", sender.tag)
        if sender.tag == 1 {
            delegate?.setImage(forName: "BankLogo")
        } else if sender.tag == 2 {
            delegate?.setImage(forName: "SendToWallet")
        } else if sender.tag == 3 {
            delegate?.setImage(forName: "SendToATM")
        } else if sender.tag == 4 {
            delegate?.setImage(forName: "History")
        }
    }
}
