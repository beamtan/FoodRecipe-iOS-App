//
//  PopularRecipeCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import Kingfisher

class PopularRecipeCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "PopularRecipeCollectionViewCell"
    
    var likeClosure: (() -> ())?
    var foodClosure: (() -> ())?
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var calorieLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    
    @IBOutlet weak private var favouriteButtonView: UIView!
    @IBOutlet weak private var favouriteImageView: UIImageView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(favouritePressed))
            favouriteImageView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var cardView: UIView! {
        didSet {
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOpacity = 0.1
            cardView.layer.shadowOffset = CGSize(width: 0, height: 1)
            cardView.layer.shadowRadius = 2
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(foodPressed))
            cardView.addGestureRecognizer(gesture)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(meal: HomeModels.MealsResponse.Meals) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: meal.strMealThumb ?? ""))
        
        titleLabel.text = meal.strMeal ?? ""
    }
    
    @objc private func favouritePressed() {
        print("Fav")
    }
    
    @objc private func foodPressed() {
        foodClosure?()
    }
}
