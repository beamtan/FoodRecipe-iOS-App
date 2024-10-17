//
//  CategoryCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 10/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "CategoryCollectionViewCell"
    
    var categoryClosure: ((String) -> ())?
    
    private var name: String = ""
    
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var categoryView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(categoryViewPress))
            categoryView.addGestureRecognizer(gesture)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUp(name: String, isSelectedCategory: Bool) {
        categoryLabel.text = name
        categoryLabel.textColor = isSelectedCategory ? .white : ._0_A_2533
        categoryView.backgroundColor = isSelectedCategory ? ._70_B_9_BE : .E_6_EBF_2
        
        self.name = name
    }
    
    @objc private func categoryViewPress() {
        categoryClosure?(name)
    }
}
