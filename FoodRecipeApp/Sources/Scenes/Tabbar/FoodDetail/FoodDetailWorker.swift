//
//  FoodDetailWorker.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class FoodDetailWorker {
    func constructProperFoodDetailResponse(response: FoodDetailModels.FoodDetailResponse) -> FoodDetailModels.FoodDetailResponse {
        
        /// Prevent Duplicate Items, Negative ID
        /// Lead to error display
        
        var filteredIngredients = response.extendedIngredients?.filter { $0.id ?? 0 >= 0 }
        filteredIngredients = Array(Set(filteredIngredients ?? []))
        
        let vegetarian = response.vegetarian
        let vegan = response.vegan
        let glutenFree = response.glutenFree
        let dairyFree = response.dairyFree
        let veryHealthy = response.veryHealthy
        let cheap = response.cheap
        let veryPopular = response.veryPopular
        let sustainable = response.sustainable
        let lowFodmap = response.lowFodmap
        let weightWatcherSmartPoints = response.weightWatcherSmartPoints
        let gaps = response.gaps
        let preparationMinutes = response.preparationMinutes
        let cookingMinutes = response.cookingMinutes
        let aggregateLikes = response.aggregateLikes
        let healthScore = response.healthScore
        let creditsText = response.creditsText
        let sourceName = response.sourceName
        let pricePerServing = response.pricePerServing
        let id = response.id
        let title = response.title
        let readyInMinutes = response.readyInMinutes
        let servings = response.servings
        let sourceURL = response.sourceURL
        let image = response.image
        let imageType = response.imageType
        let nutrition = response.nutrition
        let summary = response.summary
        let cuisines = response.cuisines
        let dishTypes = response.dishTypes
        let diets = response.diets
        let occasions = response.occasions
        let instructions = response.instructions
        let analyzedInstructions = response.analyzedInstructions
        let originalId = response.originalId
        let spoonacularScore = response.spoonacularScore
        let spoonacularSourceURL = response.spoonacularSourceURL

        let filteredResponse = FoodDetailModels.FoodDetailResponse(
            vegetarian: vegetarian,
            vegan: vegan,
            glutenFree: glutenFree,
            dairyFree: dairyFree,
            veryHealthy: veryHealthy,
            cheap: cheap,
            veryPopular: veryPopular,
            sustainable: sustainable,
            lowFodmap: lowFodmap,
            weightWatcherSmartPoints: weightWatcherSmartPoints,
            gaps: gaps,
            preparationMinutes: preparationMinutes,
            cookingMinutes: cookingMinutes,
            aggregateLikes: aggregateLikes,
            healthScore: healthScore,
            creditsText: creditsText,
            sourceName: sourceName,
            pricePerServing: pricePerServing,
            extendedIngredients: filteredIngredients,
            id: id,
            title: title,
            readyInMinutes: readyInMinutes,
            servings: servings,
            sourceURL: sourceURL,
            image: image,
            imageType: imageType,
            summary: summary,
            nutrition: nutrition,
            cuisines: cuisines,
            dishTypes: dishTypes,
            diets: diets,
            occasions: occasions,
            instructions: instructions,
            analyzedInstructions: analyzedInstructions,
            originalId: originalId,
            spoonacularScore: spoonacularScore,
            spoonacularSourceURL: spoonacularSourceURL
        )
        
        return filteredResponse
    }
}
