//
//  FeaturedCardCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 10/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class FeaturedCardCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "FeaturedCardCollectionViewCell"
    
    @IBOutlet weak private var featuredCardImageView: UIImageView!
    
    func setUp(image: UIImage) {
        featuredCardImageView.image = image
    }
}
