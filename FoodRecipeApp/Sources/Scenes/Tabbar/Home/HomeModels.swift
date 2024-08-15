//
//  HomeModels.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

struct HomeModels {
    
    struct InquiryFoodCategories {
        struct Request {
            
        }
        
        struct Response {
            let data: WelcomeResponse?
            let error: Error?
        }
        
        struct ViewModel {
            let data: WelcomeResponse?
            let error: Error?
        }
    }
    
    struct InquirySearchFoodsByCategory {
        struct Request {
            let category: String
        }
        
        struct Response {
            let data: MealsResponse?
            let error: Error?
        }
        
        struct ViewModel {
            let data: MealsResponse?
            let error: Error?
        }
    }
    
    // MARK: - Image Data
    
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
    
    // MARK: - Service Response
    
    struct WelcomeResponse: Codable {
        var categories: [Category?]?
        
        struct Category: Codable {
            let idCategory: String?
            let strCategory: String?
            let strCategoryThumb: String?
            let strCategoryDescription: String?
            
            var isSelected: Bool? = false
        }
    }
    
    struct MealsResponse: Codable {
        let meals: [Meals?]?
        
        struct Meals: Codable {
            let strMeal: String?
            let strMealThumb: String?
            let idMeal: String?
        }
    }
}
