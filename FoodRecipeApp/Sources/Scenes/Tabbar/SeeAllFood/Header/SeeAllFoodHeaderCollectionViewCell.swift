//
//  SeeAllFoodHeaderCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 21/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class SeeAllFoodHeaderCollectionViewCell: UICollectionViewCell {
    
    var backClosure: (() -> ())?
    
    @IBOutlet weak private var backButtonView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(backButtonPressed))
            backButtonView.addGestureRecognizer(gesture)
        }
    }
    
    @IBOutlet weak private var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(category: HomeModels.Category.CategoryType) {
        titleLabel.text = category.rawValue
    }
    
    @objc func backButtonPressed() {
        backClosure?()
    }
}
