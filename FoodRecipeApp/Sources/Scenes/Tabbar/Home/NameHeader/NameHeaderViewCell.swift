//
//  NameHeaderViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 15/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class NameHeaderViewCell: UICollectionViewCell {
    static let identifier: String = "NameHeaderViewCell"
    
    @IBOutlet weak private var displayNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUp(displayName: String) {
        displayNameLabel.text = displayName
    }
}
