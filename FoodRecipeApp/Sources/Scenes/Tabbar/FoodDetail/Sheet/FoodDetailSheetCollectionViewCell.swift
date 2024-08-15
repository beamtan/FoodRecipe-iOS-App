//
//  FoodDetailSheetCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 15/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class FoodDetailSheetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var ingredientButton: UIButton!
    @IBOutlet weak private var instructionButton: UIButton!
    @IBOutlet weak private var totalIngredientLabel: UILabel!
    
    @IBAction func ingredientPressed(_ sender: UIButton) {
    }
    
    @IBAction func instructionPressed(_ sender: UIButton) {
    }
}
