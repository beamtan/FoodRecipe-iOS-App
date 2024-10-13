//
//  SavedRecipePresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 14/10/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SavedRecipePresentationLogic {
    func presentInquiryFavoriteFoods(response: SavedRecipeModels.InquiryFavoriteFoods.Response)
    
    /// Route
    func presentPrepareRouteToFoodDetail()
}

class SavedRecipePresenter: SavedRecipePresentationLogic {
    weak var viewController: SavedRecipeDisplayLogic?
    
    func presentInquiryFavoriteFoods(response: SavedRecipeModels.InquiryFavoriteFoods.Response) {
        let viewModel = SavedRecipeModels.InquiryFavoriteFoods.ViewModel(data: response.data)
        viewController?.displayInquiryFavoriteFoods(viewModel: viewModel)
    }
    
    // MARK: - Prepare Routing
    
    func presentPrepareRouteToFoodDetail() {
        viewController?.displayPrepareRouteToFoodDetailSuccess()
    }
}
