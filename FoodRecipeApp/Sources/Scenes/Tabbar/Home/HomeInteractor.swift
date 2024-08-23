//
//  HomeInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func inquirySearchFoodsByCategory(request: HomeModels.InquirySearchFoodsByCategory.Request)
    
    /// Route
    func prepareRouteToFoodDetail(food: FoodDetailModels.FoodDetailResponse)
}

protocol HomeDataStore {
    var food: FoodDetailModels.FoodDetailResponse? { get set }
    var category: HomeModels.Category.CategoryType? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorkerProtocol?
    
    var food: FoodDetailModels.FoodDetailResponse?
    var category: HomeModels.Category.CategoryType?
    
    func inquirySearchFoodsByCategory(request: HomeModels.InquirySearchFoodsByCategory.Request) {
        worker = MockHomeWorker()
        
        updateCategory(request: request)
        
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
    
    // MARK: - Update Function
    
    func updateCategory(request: HomeModels.InquirySearchFoodsByCategory.Request) {
        category = HomeModels.Category.CategoryType.allCases.first(where: { $0.rawValue == request.category })
    }
    
    // MARK: - Prepare Routing
    
    func prepareRouteToFoodDetail(food: FoodDetailModels.FoodDetailResponse) {
        self.food = food
        presenter?.presentPrepareRouteToFoodDetail()
    }
}
