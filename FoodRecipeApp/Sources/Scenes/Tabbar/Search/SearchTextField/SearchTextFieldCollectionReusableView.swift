//
//  SearchTextFieldCollectionReusableView.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 13/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class SearchTextFieldCollectionReusableView: UICollectionReusableView {
    
    var textFieldShouldReturnClosure: ((_ text: String) -> ())?
    
    @IBOutlet weak private var textFieldView: UIView!
    @IBOutlet weak private var searchTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchTextField.delegate = self
        searchTextField.returnKeyType = .search
    }
    
}

extension SearchTextFieldCollectionReusableView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldShouldReturnClosure?(textField.text ?? "")
    }
}
