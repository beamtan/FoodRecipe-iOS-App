//
//  PopularRecipeHeaderCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 15/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class PopularRecipeHeaderCollectionViewCell: UICollectionViewCell {
    
    var seeAllClosure: (() -> ())?
    
    @IBOutlet weak private var seeAllButtonView: UILabel! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(seeAllPressed))
            seeAllButtonView.addGestureRecognizer(gesture)
        }
    }
    
    @objc private func seeAllPressed() {
        seeAllClosure?()
    }
}
