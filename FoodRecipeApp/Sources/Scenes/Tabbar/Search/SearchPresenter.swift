//
//  SearchPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentSearchFoodsByQuery(response: HomeModels.InquirySearchFoodsByQueryText.Response)
    
    /// Route
    func presentPrepareRouteToFoodDetail()
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentSearchFoodsByQuery(response: HomeModels.InquirySearchFoodsByQueryText.Response) {
        guard response.error == nil else {
            let viewModel = HomeModels.InquirySearchFoodsByQueryText.ViewModel(data: nil, error: response.error)
            viewController?.displaySearchFoodsByQueryFailure(viewModel: viewModel)
            
            return
        }
        
        let viewModel = HomeModels.InquirySearchFoodsByQueryText.ViewModel(data: response.data, error: nil)
        viewController?.displaySearchFoodsByQuerySuccess(viewModel: viewModel)
    }
    
    // MARK: - Prepare Routing
    
    func presentPrepareRouteToFoodDetail() {
        viewController?.displayPrepareRouteToFoodDetailSuccess()
    }
}
