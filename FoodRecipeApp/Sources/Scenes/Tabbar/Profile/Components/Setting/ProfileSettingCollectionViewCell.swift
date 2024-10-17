//
//  ProfileSettingCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 14/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class ProfileSettingCollectionViewCell: UICollectionViewCell {
    
    var settingPressClosure: (() -> ())?
    
    @IBOutlet weak private var cardView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(settingPressed))
            cardView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak private var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(labelText: String) {
        label.text = labelText
    }
    
    func makeTopRoundCorner() {
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 16
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func makeBottomRoundCorner() {
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 16
        cardView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    @objc func settingPressed() {
        settingPressClosure?()
    }
}
