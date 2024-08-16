//
//  FoodDetailPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol FoodDetailPresentationLogic {
    func presentInquiryFoodDetail(response: FoodDetailModels.InquiryFoodDetail.Response)
    func presentInquiryFoodNutrition(response: FoodDetailModels.InquiryFoodNutrition.Response)
}

class FoodDetailPresenter: FoodDetailPresentationLogic {
    weak var viewController: FoodDetailDisplayLogic?
    
    func presentInquiryFoodDetail(response: FoodDetailModels.InquiryFoodDetail.Response) {
        guard response.error == nil else {
            let viewModel = FoodDetailModels.InquiryFoodDetail.ViewModel(data: nil, error: response.error)
            viewController?.displayInquiryFoodDetailFailure(viewModel: viewModel)
            
            return
        }

        let viewModel = FoodDetailModels.InquiryFoodDetail.ViewModel(data: response.data, error: nil)
        viewController?.displayInquiryFoodDetailSuccess(viewModel: viewModel)
    }
    
    func presentInquiryFoodNutrition(response: FoodDetailModels.InquiryFoodNutrition.Response) {
        guard response.error == nil else {
            let viewModel = FoodDetailModels.InquiryFoodNutrition.ViewModel(data: nil, error: response.error)
            viewController?.displayInquiryFoodNutritionFailure(viewModel: viewModel)
            
            return
        }

        let viewModel = FoodDetailModels.InquiryFoodNutrition.ViewModel(data: response.data, error: nil)
        viewController?.displayInquiryFoodNutritionSuccess(viewModel: viewModel)
    }
}
