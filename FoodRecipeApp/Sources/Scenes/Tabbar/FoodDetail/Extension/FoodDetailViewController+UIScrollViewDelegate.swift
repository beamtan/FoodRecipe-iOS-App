//
//  FoodDetailViewController+UIScrollViewDelegate.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 16/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

extension FoodDetailViewController: UIScrollViewDelegate {
    
    // Make the effect of disappear header and stretch image
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y // down = -, up = +
        
        let originSheetY: CGFloat = -59.0
        let intersectionPointOfSheetAndHeader: CGFloat = 93
        
        let isImageBeginStretch: Bool = offsetY < originSheetY
        let isHeaderShow: Bool = offsetY > intersectionPointOfSheetAndHeader
        let isHeaderViewAlreadyHidden: Bool = headerView.layer.opacity == 0
        
        // In which any way image will change by height or padding eventually
        
        if isImageBeginStretch {
            // Stretching mean image is only getting bigger so the different should be positive only
            
            let differentBetweenSheetAndImage: CGFloat = abs(offsetY) - abs(originSheetY)
            let imageOriginHeight: CGFloat = 280
            
            foodImageViewHeight.constant = imageOriginHeight + differentBetweenSheetAndImage
        } else {
            let differentBetweenSheetAndImage: CGFloat = offsetY - originSheetY
            let isUpDirection: Bool = differentBetweenSheetAndImage > 0
            
            if isUpDirection && !isHeaderShow {
                // Divide by 3 for slower rate compare to sheet
                // Make it negative for up direction
                
                foodImageViewTopPadding.constant = (differentBetweenSheetAndImage / 3) * -1
            }
        }
        
        if isHeaderShow {
            let differentSheetAndHeaderOverlap: CGFloat = abs(intersectionPointOfSheetAndHeader) - abs(offsetY)
            
            // To make opacity from the different point of y
            // Divide by 100 to make the different smoothly with ratio as 0 is min opacity and 1 is max opacity
            
            headerView.layer.opacity = Float(min(abs(differentSheetAndHeaderOverlap) / 100, 1))
            closeButtonSolidBG.layer.opacity = Float((1 - (abs(differentSheetAndHeaderOverlap) / 100)))
            likeButtonSolidBG.layer.opacity = Float((1 - (abs(differentSheetAndHeaderOverlap) / 100)))
            
            return
        }
        
        if isHeaderViewAlreadyHidden {
            return
        }
        
        headerView.layer.opacity = 0
        closeButtonSolidBG.layer.opacity = 1
        likeButtonSolidBG.layer.opacity = 1
    }
}
