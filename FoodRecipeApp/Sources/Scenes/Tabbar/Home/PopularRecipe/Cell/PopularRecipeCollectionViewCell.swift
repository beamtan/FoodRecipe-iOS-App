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
    
    @IBOutlet weak private var favouriteImageView: UIImageView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(favouritePressed))
            favouriteImageView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var cardView: UIView! {
        didSet {
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOpacity = 0.05
            cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
            cardView.layer.shadowRadius = 4
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(food: HomeModels.SearchFoodsResponse.Result) {
        let calories = food.nutrition?.nutrients?.first(where: { $0.name == "Calories" })
        let caloriesAmount: Int = calories?.amount?.int ?? 0
        let caloriesUnit: String = calories?.unit ?? ""
        
        let time: String = food.readyInMinutes == nil ? "--" : "\(food.readyInMinutes!)"
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: food.image ?? ""), placeholder: UIImage(named: "imagePlaceholder"))
        
        titleLabel.text = food.title
        calorieLabel.text = "\(caloriesAmount) \(caloriesUnit)"
        timeLabel.text = "\(time) Min"
        
        if let id = food.id {
            favouriteImageView.image = isFavouriteFood(id: id) ? UIImage(named: "fullHeartIcon") : UIImage(named: "heartIcon")
        }
    }
    
    private func isFavouriteFood(id: Int) -> Bool {
        let favFood = UserDefaultService.shared.getFavouriteFoods() ?? []
        if !favFood.contains(where: { $0.id == id }) {
            return false
        }
        
        return true
    }
    
    @objc private func favouritePressed() {
        print("Fav")
    }
    
    @objc private func foodPressed() {
        foodClosure?()
    }
}
