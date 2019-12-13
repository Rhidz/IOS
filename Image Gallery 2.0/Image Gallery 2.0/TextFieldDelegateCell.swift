//
//  TextFiledDelegateCell.swift
//  Image Gallery 2.0
//
//  Created by Admin on 08/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class TextFieldDelegateCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!{
        didSet {
            textField.delegate = self
            textField.clearsOnBeginEditing = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var resignHandler : (()-> Void)?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        resignHandler?()
    }

}
