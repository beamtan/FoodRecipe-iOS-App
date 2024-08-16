//
//  IngredientCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 15/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import Kingfisher

class IngredientCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var customBackgroundView: UIView!
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
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
    
    // MARK: - Function
    
    func setup(ingredient: FoodDetailModels.FoodDetailResponse.ExtendedIngredient) {
        let imageUrl: String = "https://img.spoonacular.com/ingredients_100x100/\(ingredient.image ?? "")"
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "imagePlaceholder"))
        
        titleLabel.text = ingredient.original
    }
}
