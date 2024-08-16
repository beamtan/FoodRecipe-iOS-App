//
//  FoodDetailModels.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

struct FoodDetailModels {
    
    struct InquiryFoodDetail {
        struct Request {
            let id: String
        }
        
        struct Response {
            let data: FoodDetailResponse?
            let error: Error?
        }
        
        struct ViewModel {
            let data: FoodDetailResponse?
            let error: Error?
        }
    }
    
    struct InquiryFoodNutrition {
        struct Request {
            let id: String
        }
        
        struct Response {
            let data: FoodNutritionResponse?
            let error: Error?
        }
        
        struct ViewModel {
            let data: FoodNutritionResponse?
            let error: Error?
        }
    }
    
    // MARK: - Service Response: Spoonacular
    
    struct FoodDetailResponse: Codable {
        let vegetarian, vegan, glutenFree, dairyFree: Bool?
        let veryHealthy, cheap, veryPopular, sustainable: Bool?
        let lowFodmap: Bool?
        let weightWatcherSmartPoints: Int?
        let gaps: String?
        let preparationMinutes, cookingMinutes: Int?
        let aggregateLikes, healthScore: Int?
        let creditsText, sourceName: String?
        let pricePerServing: Double?
        let extendedIngredients: [ExtendedIngredient]?
        let id: Int?
        let title: String?
        let readyInMinutes, servings: Int?
        let sourceURL: String?
        let image: String?
        let imageType, summary: String?
        let nutrition: Nutrition?
        let cuisines: [String]?
        let dishTypes, diets: [String]?
        let occasions: [String]?
        let instructions: String?
        let analyzedInstructions: [AnalyzedInstruction]?
        let originalId: String?
        let spoonacularScore: Double?
        let spoonacularSourceURL: String?
        
        // MARK: - AnalyzedInstruction
        struct AnalyzedInstruction: Codable {
            let name: String?
            let steps: [Step]?
        }

        // MARK: - Step
        struct Step: Codable {
            let number: Int?
            let step: String?
            let ingredients, equipment: [Ent]?
            let length: Length?
            
            // MARK: - Ent
            struct Ent: Codable {
                let id: Int
                let name, localizedName: String?
                let image: String?
                let temperature: Length?
            }
            
            // MARK: - Length
            struct Length: Codable {
                let number: Int?
                let unit: String?
            }
        }

        // MARK: - ExtendedIngredient
        struct ExtendedIngredient: Codable, Hashable {
            var hashValue: Int { get { return id.hashValue } }
            let id: Int?
            let aisle, image: String?
            let consistency: String?
            let name, nameClean, original, originalName: String?
            let amount: Double?
            let unit: String?
            let meta: [String]?
            let measures: Measures?
            
            // MARK: - Measures
            struct Measures: Codable {
                let us, metric: Metric?
                
                // MARK: - Metric
                struct Metric: Codable {
                    let amount: Double?
                    let unitShort, unitLong: String?
                }
            }
            
            /// To Prevent Duplicate Ingredient
            
            func hash(into hasher: inout Hasher) {
                hasher.combine(id)
            }
            
            static func == (lhs: ExtendedIngredient, rhs: ExtendedIngredient) -> Bool {
                return lhs.id == rhs.id
            }
        }
        
        // MARK: - Nutrition
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
    
    // MARK: - Nutrition
    
    struct FoodNutritionResponse: Codable {
        let calories, carbs, fat, protein: String?
        let bad, good: [Bad]?
        let nutrients, properties, flavonoids: [Flavonoid]?
        let ingredients: [Ingredient]?
        let caloricBreakdown: CaloricBreakdown?
        let weightPerServing: WeightPerServing?
        let expires: Int?
        let isStale: Bool?
        
        // MARK: - Bad
        struct Bad: Codable {
            let amount: String?
            let indented: Bool?
            let title: String?
            let percentOfDailyNeeds: Double?
        }
        
        // MARK: - CaloricBreakdown
        struct CaloricBreakdown: Codable {
            let percentFat, percentCarbs, percentProtein: Double?
        }
        
        // MARK: - Flavonoid
        struct Flavonoid: Codable {
            let name: String?
            let amount: Double?
            let unit: String?
            let percentOfDailyNeeds: Double?
        }
        
        // MARK: - Ingredient
        struct Ingredient: Codable {
            let name: String?
            let amount: Double?
            let unit: String?
            let id: Int?
            let nutrients: [Flavonoid]?
        }

        // MARK: - WeightPerServing
        struct WeightPerServing: Codable {
            let amount: Int?
            let unit: String?
        }
    }
}
