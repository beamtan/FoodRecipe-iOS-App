//
//  HomeModels.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

struct HomeModels {
    
    struct Category {
        var name: String
        var isSelected: Bool
    }
    
    struct Recipe {
        let imageUrl: String
        let title: String
        let calorie: Int
        let time: String
        let isFavourite: Bool
    }
}
