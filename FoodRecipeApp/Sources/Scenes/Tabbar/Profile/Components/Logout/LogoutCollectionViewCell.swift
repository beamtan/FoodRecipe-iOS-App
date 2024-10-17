//
//  LogoutCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 15/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class LogoutCollectionViewCell: UICollectionViewCell {
    
    var logoutClosure: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        logoutClosure?()
    }
}
