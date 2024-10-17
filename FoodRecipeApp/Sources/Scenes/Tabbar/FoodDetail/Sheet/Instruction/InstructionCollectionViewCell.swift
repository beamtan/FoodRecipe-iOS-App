//
//  InstructionCollectionViewCell.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 17/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class InstructionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var stepNumberLabel: UILabel!
    @IBOutlet weak private var instructionDetailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(instruction: FoodDetailModels.FoodDetailResponse.Step) {
        stepNumberLabel.text = (instruction.number?.string ?? "") + "."
        instructionDetailLabel.text = instruction.step
    }
    
    /// PreferredLayoutAttributesFitting solve my cell fixed layout to flexible height
    ///
    /// - This method overrides the default layout attribute fitting behavior to dynamically adjust the height of the cell based on its content.
   
    /// - By overriding this method, the cell's height will automatically adjust to    accommodate its content, resulting in a flexible, dynamic
    /// cell height that prevents issues such as text clipping or excess whitespace.
    
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        instructionDetailLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.right
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        ).height
        return layoutAttributes
    }
}
