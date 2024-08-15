//
//  ProfileFavCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class ProfileFavCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "ProfileFavCollectionViewCell"
    
    @IBOutlet weak private var cardView: UIView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var likeButtonView: UIView!
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
}
