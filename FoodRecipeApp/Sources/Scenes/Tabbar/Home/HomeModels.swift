//
//  HomeModels.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

struct HomeModels {
    
    struct InquirySearchFoodsByQueryText {
        struct Request {
            let query: String
            let number: Int
            let isAddRecipeNutrition: Bool
            let isAddRecipeInstructions: Bool
            let isFillIngredients: Bool
            var sort: String? = nil
            var sortDirection: String? = nil
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
        let results: [FoodDetailModels.FoodDetailResponse]?
        let offset, number, totalResults: Int?
        
        struct Result: Codable {
            let vegetarian, vegan, glutenFree, dairyFree: Bool?
            let veryHealthy, cheap, veryPopular, sustainable: Bool?
            let lowFodmap: Bool?
            let weightWatcherSmartPoints: Int?
            let gaps: String?
            let preparationMinutes, cookingMinutes: Int?
            let aggregateLikes, healthScore: Int?
            let creditsText, sourceName: String?
            let pricePerServing: Double?
            let id: Int?
            let title: String?
            let readyInMinutes, servings: Int?
            let sourceURL: String?
            let image: String?
            let imageType: String?
            let nutrition: Nutrition?
            let summary: String?
            let cuisines, dishTypes, diets, occasions: [String]?
            let spoonacularScore: Double?
            let spoonacularSourceURL: String?
            let license: String?
            
            struct Nutrition: Codable {
                let nutrients, properties, flavonoids: [Flavonoid]?
                let ingredients: [Ingredient]?
                let caloricBreakdown: CaloricBreakdown?
                let weightPerServing: WeightPerServing?
                
                struct Flavonoid: Codable {
                    let name: String?
                    let amount: Double?
                    let unit: String?
                    let percentOfDailyNeeds: Double?
                }
                
                struct Ingredient: Codable {
                    let id: Int?
                    let name: String?
                    let amount: Double?
                    let unit: String?
                    let nutrients: [Flavonoid]?
                }
                
                struct CaloricBreakdown: Codable {
                    let percentProtein, percentFat, percentCarbs: Double?
                }
                
                struct WeightPerServing: Codable {
                    let amount: Int?
                    let unit: String?
                }
            }
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
