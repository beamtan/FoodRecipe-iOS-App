//
//  SeeAllFoodInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 21/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SeeAllFoodBusinessLogic {
    // Call Service
    func inquirySearchFoodsByCategory(request: HomeModels.InquirySearchFoodsByCategory.Request)
    
    // Get Data Store
    func getCategoryValue(request: SeeAllFoodModels.Category.Request)
    
    // Routing
    func prepareRouteToFoodDetail(food: FoodDetailModels.FoodDetailResponse)
}

protocol SeeAllFoodDataStore {
    var category: HomeModels.Category.CategoryType? { get set }
    var food: FoodDetailModels.FoodDetailResponse? { get set }
}

class SeeAllFoodInteractor: SeeAllFoodBusinessLogic, SeeAllFoodDataStore {
    var presenter: SeeAllFoodPresentationLogic?
    var worker: SeeAllFoodWorkerProtocol?
    
    var category: HomeModels.Category.CategoryType?
    var food: FoodDetailModels.FoodDetailResponse?
    
    func inquirySearchFoodsByCategory(request: HomeModels.InquirySearchFoodsByCategory.Request) {
        worker = MockSeeAllFoodWorker()
        
        worker?.inquirySearchFoodsByCategory(request: request) { [weak self] (data) in
            guard let self else { return }
            
            switch data.result {
            case .success(let response):
                let response = HomeModels.InquirySearchFoodsByCategory.Response(data: response, error: nil)
                presenter?.presentInquirySearchFoodsByCategory(response: response)
            case .failure(let error):
                let response = HomeModels.InquirySearchFoodsByCategory.Response(data: nil, error: error)
                presenter?.presentInquirySearchFoodsByCategory(response: response)
            }
        }
    }
    
    func getCategoryValue(request: SeeAllFoodModels.Category.Request) {
        guard let category else { return }
        
        let response = SeeAllFoodModels.Category.Response(category: category)
        presenter?.presentGetCategoryValue(response: response)
    }
    
    // MARK: - Prepare Routing
    
    func prepareRouteToFoodDetail(food: FoodDetailModels.FoodDetailResponse) {
        self.food = food
        presenter?.presentPrepareRouteToFoodDetail()
    }
}
