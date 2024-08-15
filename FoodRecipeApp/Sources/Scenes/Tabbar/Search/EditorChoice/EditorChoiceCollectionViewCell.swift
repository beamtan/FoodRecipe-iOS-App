//
//  EditorChoiceCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class EditorChoiceCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "EditorChoiceCollectionViewCell"
    
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
}
