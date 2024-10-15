//
//  ProfileFavCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileFavCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "ProfileFavCollectionViewCell"
    
    var foodClosure: (() -> ())?
    
    @IBOutlet weak private var cardView: UIView! {
        didSet {
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOpacity = 0.1
            cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cardView.layer.shadowRadius = 5
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(foodPressed))
            cardView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var likeButtonView: UIView!
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var calorieLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setup(favFood: FoodDetailModels.FoodDetailResponse) {
        let calories = favFood.nutrition?.nutrients?.first(where: { $0.name == "Calories" })
        let caloriesAmount: Int = calories?.amount?.int ?? 0
        let caloriesUnit: String = calories?.unit ?? ""
        
        let time: String = favFood.readyInMinutes == nil ? "--" : "\(favFood.readyInMinutes ?? 0)"
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: favFood.image ?? ""), placeholder: UIImage(named: "imagePlaceholder"))
        
        titleLabel.text = favFood.title
        
        calorieLabel.text = "\(caloriesAmount)"
        timeLabel.text = "\(time) Min"
    }
    
    @objc private func foodPressed() {
        foodClosure?()
    }
}
