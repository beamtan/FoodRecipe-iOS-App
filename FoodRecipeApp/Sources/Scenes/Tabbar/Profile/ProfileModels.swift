//
//  ProfileModels.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

struct ProfileModels {
    
    struct InquiryFavouriteFoods {
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
