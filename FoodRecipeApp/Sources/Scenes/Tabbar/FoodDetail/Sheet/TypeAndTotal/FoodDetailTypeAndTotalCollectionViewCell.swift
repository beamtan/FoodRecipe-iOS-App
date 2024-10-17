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
    
    
    @IBOutlet weak private var customBackgroundView: UIView!
    @IBOutlet weak private var foodDetailTypeLabel: UILabel!
    @IBOutlet weak private var totalItemLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        customBackgroundView.backgroundColor = .white
    }
    
    // MARK: - Function
    
    func setup(type: FoodDetailModels.FoodDetailType, total: Int) {
        let totalDisplay: String
        switch type {
        case .ingredient:
            totalDisplay = (total > 1) ? "items" : "item"
        case .instruction:
            totalDisplay = (total > 1) ? "steps" : "step"
        }
        
        foodDetailTypeLabel.text = type.rawValue
        totalItemLabel.text = "\(total) \(totalDisplay)"
    }
}
