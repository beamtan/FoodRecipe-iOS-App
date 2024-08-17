//
//  HomeModels.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

struct HomeModels {
    
    struct InquirySearchFoodsByCategory {
        struct Request {
            let category: String
            let number: Int
        }
        
        struct Response {
            let data: SearchFoodsResponse?
            let error: Error?
        }
        
        struct ViewModel {
            let data: SearchFoodsResponse?
            let error: Error?
        }
    }
    
    // MARK: - Service Response: themealdb
    
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
    
    // MARK: - Service Response: Spoonacular
    
    struct SearchFoodsResponse: Codable {
        let results: [Result]?
        let offset, number, totalResults: Int?
        
        struct Result: Codable {
            let id: Int?
            let title: String?
            let imageType: String?
            let image: String?
        }
    }
    
    // Static Data for Category button
    
    struct Category: Codable {
        var categories: [CategorySaved]
        
        struct CategorySaved: Codable {
            let category: CategoryType
            var isSelected: Bool
        }
        
        enum CategoryType: String, Codable, CaseIterable {
            case mainCourse = "Main Course"
            case sideDish = "Side Dish"
            case dessert = "Dessert"
            case appetizer = "Appetizer"
            case salad = "Salad"
            case bread = "Bread"
            case breakfast = "Breakfast"
            case soup = "Soup"
            case beverage = "Beverage"
            case sauce = "Sauce"
            case marinade = "Marinade"
            case fingerFood = "Fingerfood"
            case snack = "Snack"
            case drink = "Drink"
        }
        
        init() {
            var categories = [CategorySaved]()
            for (index, type) in CategoryType.allCases.enumerated() {
                categories.append(CategorySaved(category: type, isSelected: index == 0))
            }
            self.categories = categories
        }
    }
}
