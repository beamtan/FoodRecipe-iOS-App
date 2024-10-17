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
    
    @IBOutlet weak private var cardView: UIView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
    }
    
    // MARK: - Function
    
    private func setupView() {
        guard let cardView else {
            return
        }
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.layer.shadowRadius = 5
    }
    
    func setup(ingredient: FoodDetailModels.FoodDetailResponse.ExtendedIngredient) {
        let imageUrl: String = "https://img.spoonacular.com/ingredients_100x100/\(ingredient.image ?? "")"
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "imagePlaceholder"))
        
        titleLabel.text = ingredient.original
    }
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        let imageWidth: CGFloat = 48.0
        let imagePadding: CGFloat = 24.0 + 16.0
        titleLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.right - imageWidth - imagePadding
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        ).height
        return layoutAttributes
    }
}
