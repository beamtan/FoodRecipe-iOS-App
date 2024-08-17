//
//  FoodDetailTypeAndTotalCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 18/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class FoodDetailTypeAndTotalCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var foodDetailTypeLabel: UILabel!
    @IBOutlet weak private var totalItemLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Function
    
    func setup(type: String, total: Int) {
        let totalDisplay: String = total > 1 ? "items" : "item"
        
        foodDetailTypeLabel.text = type
        totalItemLabel.text = "\(total) \(totalDisplay)"
    }
}
