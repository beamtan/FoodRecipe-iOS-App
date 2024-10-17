//
//  SavedRecipeTitleCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 14/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class SavedRecipeTitleCollectionViewCell: UICollectionViewCell {

    var gridButtonClosured: (() -> ())?
    var tableButtonClosured: (() -> ())?
    
    @IBOutlet weak private var gridButtonView: UIImageView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(gridPressed))
            gridButtonView.addGestureRecognizer(gesture)
            gridButtonView.tintColor = ._0_A_2533
        }
    }
    @IBOutlet weak private var tableButtonView: UIImageView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tablePressed))
            tableButtonView.addGestureRecognizer(gesture)
            tableButtonView.tintColor = ._0_A_2533
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func gridEnable() {
        if let image = UIImage(systemName: "circle.grid.2x2.fill") {
            
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let self else { return }
                
                gridButtonView.image = image
            })
            
        }
    }
    
    private func tableEnable() {
        if let image = UIImage(systemName: "tablecells.fill") {
            
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let self else { return }
                
                tableButtonView.image = image
            })
        }
    }
    
    private func gridDisable() {
        if let image = UIImage(systemName: "circle.grid.2x2") {
            
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let self else { return }
                
                gridButtonView.image = image
            })
        }
    }
    
    private func tableDisable() {
        if let image = UIImage(systemName: "tablecells") {
            
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let self else { return }
                
                tableButtonView.image = image
            })
        }
    }
    
    @objc func gridPressed() {
        gridButtonClosured?()
        
        gridEnable()
        tableDisable()
    }
    
    @objc func tablePressed() {
        tableButtonClosured?()
        
        tableEnable()
        gridDisable()
    }
}
