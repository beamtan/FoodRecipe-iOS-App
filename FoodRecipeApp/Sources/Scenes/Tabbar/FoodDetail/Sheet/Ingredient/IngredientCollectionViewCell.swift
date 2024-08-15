//
//  IngredientCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 15/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class IngredientCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var customBackgroundView: UIView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        guard let customBackgroundView else {
            return
        }
        
        customBackgroundView.layer.shadowColor = UIColor.black.cgColor
        customBackgroundView.layer.shadowOpacity = 0.1
        customBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 2)
        customBackgroundView.layer.shadowRadius = 4
    }
}
