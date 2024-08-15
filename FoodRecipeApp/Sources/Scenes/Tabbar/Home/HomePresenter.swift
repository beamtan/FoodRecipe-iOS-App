//
//  HomePresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentInquiryCategories(response: HomeModels.InquiryFoodCategories.Response)
    func presentInquirySearchFoodsByCategory(response: HomeModels.InquirySearchFoodsByCategory.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    func presentInquiryCategories(response: HomeModels.InquiryFoodCategories.Response) {
        guard response.error == nil else {
            let viewModel = HomeModels.InquiryFoodCategories.ViewModel(data: nil, error: response.error)
            viewController?.displayInquiryFoodCategoriesFailure(viewModel: viewModel)
            
            return
        }
        
        let viewModel = HomeModels.InquiryFoodCategories.ViewModel(data: response.data, error: nil)
        viewController?.displayInquiryFoodCategoriesSuccess(viewModel: viewModel)
    }
    
    func presentInquirySearchFoodsByCategory(response: HomeModels.InquirySearchFoodsByCategory.Response) {
        guard response.error == nil else {
            let viewModel = HomeModels.InquirySearchFoodsByCategory.ViewModel(data: nil, error: response.error)
            viewController?.displayInquirySearchFoodsByCategoryFailure(viewModel: viewModel)
            
            return
        }
        
        var meals: [HomeModels.MealsResponse.Meals?] = []
        
        meals = response.data?.meals ?? []
        meals = Array(meals.prefix(6))
        
        let dataResponse = HomeModels.MealsResponse.init(meals: meals)
        
        let viewModel = HomeModels.InquirySearchFoodsByCategory.ViewModel(data: dataResponse, error: nil)
        viewController?.displayInquirySearchFoodsByCategorySuccess(viewModel: viewModel)
    }
}
