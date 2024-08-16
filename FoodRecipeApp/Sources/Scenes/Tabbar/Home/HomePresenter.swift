//
//  HomePresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentInquirySearchFoodsByCategory(response: HomeModels.InquirySearchFoodsByCategory.Response)
    func presentPrepareRouteToFoodDetail()
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    func presentInquirySearchFoodsByCategory(response: HomeModels.InquirySearchFoodsByCategory.Response) {
        guard response.error == nil else {
            let viewModel = HomeModels.InquirySearchFoodsByCategory.ViewModel(data: nil, error: response.error)
            viewController?.displayInquirySearchFoodsByCategoryFailure(viewModel: viewModel)
            
            return
        }
        
        let viewModel = HomeModels.InquirySearchFoodsByCategory.ViewModel(data: response.data, error: nil)
        viewController?.displayInquirySearchFoodsByCategorySuccess(viewModel: viewModel)
    }
    
    // MARK: - Prepare Routing
    
    func presentPrepareRouteToFoodDetail() {
        viewController?.displayPrepareRouteToFoodDetailSuccess()
    }
}
