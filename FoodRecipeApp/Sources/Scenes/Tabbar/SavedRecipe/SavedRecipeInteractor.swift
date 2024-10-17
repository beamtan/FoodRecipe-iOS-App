//
//  SavedRecipeInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 14/10/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SavedRecipeBusinessLogic {
    func inquiryFavoriteFoods(request: SavedRecipeModels.InquiryFavoriteFoods.Request)
    
    /// Route
    func prepareRouteToFoodDetail(food: FoodDetailModels.FoodDetailResponse)
}

protocol SavedRecipeDataStore {
    var food: FoodDetailModels.FoodDetailResponse? { get set }
}

class SavedRecipeInteractor: SavedRecipeBusinessLogic, SavedRecipeDataStore {
    var presenter: SavedRecipePresentationLogic?
    var worker: SavedRecipeWorker?
    
    var food: FoodDetailModels.FoodDetailResponse?
    
    func inquiryFavoriteFoods(request: SavedRecipeModels.InquiryFavoriteFoods.Request) {
        let favoriteFoods = UserDefaultService.shared.getFavouriteFoods()
        let response = SavedRecipeModels.InquiryFavoriteFoods.Response(data: favoriteFoods)
        presenter?.presentInquiryFavoriteFoods(response: response)
    }
    
    // MARK: - Prepare Routing
    
    func prepareRouteToFoodDetail(food: FoodDetailModels.FoodDetailResponse) {
        self.food = food
        presenter?.presentPrepareRouteToFoodDetail()
    }
}
