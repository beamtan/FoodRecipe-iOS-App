//
//  SearchResultTableCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 16/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class SearchResultTableCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "SearchResultTableCollectionViewCell"
    
    var foodClosure: (() -> ())?
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var calorieLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(food: FoodDetailModels.FoodDetailResponse) {
        let calories = food.nutrition?.nutrients?.first(where: { $0.name == "Calories" })
        let caloriesAmount: Int = calories?.amount?.int ?? 0
        let caloriesUnit: String = calories?.unit ?? ""
        
        let time: String = food.readyInMinutes == nil ? "--" : "\(food.readyInMinutes!)"
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: food.image ?? ""), placeholder: UIImage(named: "imagePlaceholder"))
        
        titleLabel.text = food.title
        calorieLabel.text = "\(caloriesAmount) \(caloriesUnit)"
        timeLabel.text = "\(time) Min"
    }
    
    @objc private func foodPressed() {
        foodClosure?()
    }
}
