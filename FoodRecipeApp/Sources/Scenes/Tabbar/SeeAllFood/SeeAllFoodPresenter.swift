//
//  SeeAllFoodPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 21/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SeeAllFoodPresentationLogic {
    func presentInquirySearchFoodsByCategory(response: HomeModels.InquirySearchFoodsByQueryText.Response)
    func presentGetCategoryValue(response: SeeAllFoodModels.Category.Response)
    
    func presentPrepareRouteToFoodDetail()
}

class SeeAllFoodPresenter: SeeAllFoodPresentationLogic {
    weak var viewController: SeeAllFoodDisplayLogic?
    
    func presentInquirySearchFoodsByCategory(response: HomeModels.InquirySearchFoodsByQueryText.Response) {
        guard response.error == nil else {
            let viewModel = HomeModels.InquirySearchFoodsByQueryText.ViewModel(data: nil, error: response.error)
            viewController?.displayInquirySearchFoodsByCategoryFailure(viewModel: viewModel)
            
            return
        }
        
        let viewModel = HomeModels.InquirySearchFoodsByQueryText.ViewModel(data: response.data, error: nil)
        viewController?.displayInquirySearchFoodsByCategorySuccess(viewModel: viewModel)
    }
    
    func presentGetCategoryValue(response: SeeAllFoodModels.Category.Response) {
        let viewModel = SeeAllFoodModels.Category.ViewModel(category: response.category)
        viewController?.displayGetCategoryValue(viewModel: viewModel)
    }
    
    // MARK: - Prepare Routing
    
    func presentPrepareRouteToFoodDetail() {
        viewController?.displayPrepareRouteToFoodDetailSuccess()
    }
}
