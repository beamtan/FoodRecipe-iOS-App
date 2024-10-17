//
//  SavedRecipeModels.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 14/10/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

struct SavedRecipeModels {
    struct InquiryFavoriteFoods {
        struct Request {
            
        }
        
        struct Response {
            let data: [FoodDetailModels.FoodDetailResponse]?
        }
        
        struct ViewModel {
            let data: [FoodDetailModels.FoodDetailResponse]?
        }
    }
}
