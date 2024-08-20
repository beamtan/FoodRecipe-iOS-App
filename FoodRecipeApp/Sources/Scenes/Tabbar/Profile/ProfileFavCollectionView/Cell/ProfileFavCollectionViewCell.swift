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
    
    @IBOutlet weak private var cardView: UIView! {
        didSet {
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOpacity = 0.1
            cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cardView.layer.shadowRadius = 5
        }
    }
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var likeButtonView: UIView!
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setup(favFood: FoodDetailModels.FoodDetailResponse) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: favFood.image ?? ""), placeholder: UIImage(named: "imagePlaceholder"))
        
        titleLabel.text = favFood.title
        
    }
}
