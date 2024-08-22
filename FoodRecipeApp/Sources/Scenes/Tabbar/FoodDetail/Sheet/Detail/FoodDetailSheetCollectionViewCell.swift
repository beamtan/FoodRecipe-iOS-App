//
//  FoodDetailSheetCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 15/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import SwifterSwift

class FoodDetailSheetCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var ingredientClosure: (() -> ())?
    var instructionClosure: (() -> ())?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var timeCookLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var ingredientButton: UIButton!
    @IBOutlet weak private var instructionButton: UIButton!
    
    @IBOutlet weak private var carbTitleLabel: UILabel!
    @IBOutlet weak private var proteinTitleLabel: UILabel!
    @IBOutlet weak private var caloriesTitleLabel: UILabel!
    @IBOutlet weak private var fatTitleLabel: UILabel!
    
    @IBOutlet weak private var carbLabel: UILabel!
    @IBOutlet weak private var proteinLabel: UILabel!
    @IBOutlet weak private var caloriesLabel: UILabel!
    @IBOutlet weak private var fatLabel: UILabel!
    
    // MARK: - IBAction
    
    @IBAction func ingredientPressed(_ sender: UIButton) {
        UIView.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve, animations: {
            sender.backgroundColor = ._042628
            sender.setTitleColor(.white, for: .normal)
        })
        
        UIView.transition(with: instructionButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.instructionButton.backgroundColor = .clear
            self.instructionButton.setTitleColor(._0_A_2533, for: .normal)
        })
        
        ingredientClosure?()
    }
    
    @IBAction func instructionPressed(_ sender: UIButton) {
        UIView.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve, animations: {
            sender.backgroundColor = ._042628
            sender.setTitleColor(.white, for: .normal)
        })
        
        UIView.transition(with: ingredientButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.ingredientButton.backgroundColor = .clear
            self.ingredientButton.setTitleColor(._0_A_2533, for: .normal)
        })
        
        instructionClosure?()
    }
    
    // MARK: - Setup
    
    func setup(food: FoodDetailModels.FoodDetailResponse) {
        let timeCook: Int = food.readyInMinutes ?? 0
        let credit: String = food.creditsText ?? "unknown"
        let displayTimeCook: String = timeCook > 1 ? "\(timeCook)" : "--"
        
        let nutrients: [FoodDetailModels.FoodDetailResponse.Nutrition.Flavonoid] = food.nutrition?.nutrients ?? []
        
        let carb = nutrients.first(where: { $0.name == "Carbohydrates" })
        let protein = nutrients.first(where: { $0.name == "Protein" })
        let calories = nutrients.first(where: { $0.name == "Calories" })
        let fat = nutrients.first(where: { $0.name == "Fat" })
        
        let displayCarbTitle: String = "Carbs"
        let displayProteinTitle: String = protein?.name ?? ""
        let displayCaloriesTitle: String = calories?.name ?? ""
        let displayFatTitle: String = fat?.name ?? ""
        
        let displayCarb: String = carb?.amount?.string ?? ""
        let displayProtein: String = protein?.amount?.string ?? ""
        let displayCalories: String = calories?.amount?.string ?? ""
        let displayFat: String = fat?.amount?.string ?? ""
        
        let displayCarbUnit: String = carb?.unit ?? ""
        let displayProteinUnit: String = protein?.unit ?? ""
        let displayCaloriesUnit: String = calories?.unit ?? ""
        let displayFatUnit: String = fat?.unit ?? ""
        
        titleLabel.text = food.title
        timeCookLabel.text = "\(displayTimeCook) Min"
        descriptionLabel.text = "Credit: \(credit)"
        carbLabel.text = "\(displayCarb) \(displayCarbUnit)"
        proteinLabel.text = "\(displayProtein) \(displayProteinUnit)"
        caloriesLabel.text = "\(displayCalories) \(displayCaloriesUnit)"
        fatLabel.text = "\(displayFat) \(displayFatUnit)"
        
        carbTitleLabel.text = displayCarbTitle
        proteinTitleLabel.text = displayProteinTitle
        caloriesTitleLabel.text = displayCaloriesTitle
        fatTitleLabel.text = displayFatTitle
    }
}
