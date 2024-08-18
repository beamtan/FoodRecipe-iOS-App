//
//  UserDefaultService.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 19/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import Foundation

protocol UserDefaultServiceLogic {
    func getFavouriteFoods() -> [FoodDetailModels.FoodDetailResponse]?
    func saveFavouriteFood(food: FoodDetailModels.FoodDetailResponse, completionHandler: (() -> ())?)
    func removeFavouriteFood(food: FoodDetailModels.FoodDetailResponse, completionHandler: (() -> ())?)
}

class UserDefaultService: UserDefaultServiceLogic {
    static let shared: UserDefaultServiceLogic = UserDefaultService()
    
    func getFavouriteFoods() -> [FoodDetailModels.FoodDetailResponse]? {
        guard let data = UserDefaults.standard.data(forKey: "MyFavouriteFood"),
              let favFood: [FoodDetailModels.FoodDetailResponse] = try? JSONDecoder().decode([FoodDetailModels.FoodDetailResponse].self, from: data) else {
            return nil
        }
        
        return favFood
    }
    
    func saveFavouriteFood(food: FoodDetailModels.FoodDetailResponse, completionHandler: (() -> ())? = nil) {
        var favFoods: [FoodDetailModels.FoodDetailResponse]?
        
        if let savedFavFoods = getFavouriteFoods() {
            favFoods = savedFavFoods
            favFoods?.append(food)
        } else {
            favFoods = [food]
        }
        
        if let data = try? JSONEncoder().encode(favFoods) {
            UserDefaults.standard.set(data, forKey: "MyFavouriteFood")
            completionHandler?()
        }
        
        if let favouriteFoods = getFavouriteFoods() {
            print("Updated favourite foods: \(favouriteFoods.count) <new = \(food.title)")
        }
    }
    
    func removeFavouriteFood(food: FoodDetailModels.FoodDetailResponse, completionHandler: (() -> ())? = nil) {
        var favFoods: [FoodDetailModels.FoodDetailResponse] = []
        
        guard let savedFavFoods = getFavouriteFoods(),
              let removeIndex = savedFavFoods.firstIndex(where: { $0.id == food.id })
        else { return }
        
        favFoods = savedFavFoods
        favFoods.remove(at: removeIndex)
        
        if let data = try? JSONEncoder().encode(favFoods) {
            UserDefaults.standard.set(data, forKey: "MyFavouriteFood")
            completionHandler?()
        }
        
        if let favouriteFoods = getFavouriteFoods() {
            print("Updated favourite foods: \(favouriteFoods.count) <new = \(food.title)")
        }
    }
}
