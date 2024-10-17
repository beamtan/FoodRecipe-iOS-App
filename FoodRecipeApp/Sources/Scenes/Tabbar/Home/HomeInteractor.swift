//
//  HomeInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func inquirySearchFoodsByCategory(request: HomeModels.InquirySearchFoodsByQueryText.Request)
    func inquiryUser(request: HomeModels.User.Request)
    
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
    
    func inquirySearchFoodsByCategory(request: HomeModels.InquirySearchFoodsByQueryText.Request) {
        worker = MockHomeWorker()
        
        updateCurrentCategory(request: request)
        
        worker?.inquirySearchFoodsByQuery(request: request) { [weak self] (data) in
            guard let self else { return }
            
            switch data.result {
            case .success(let response):
                let response = HomeModels.InquirySearchFoodsByQueryText.Response(data: response, error: nil)
                presenter?.presentInquirySearchFoodsByCategory(response: response)
            case .failure(let error):
                let response = HomeModels.InquirySearchFoodsByQueryText.Response(data: nil, error: error)
                presenter?.presentInquirySearchFoodsByCategory(response: response)
            }
        }
    }
    
    // MARK: - Update Function
    
    func updateCurrentCategory(request: HomeModels.InquirySearchFoodsByQueryText.Request) {
        category = HomeModels.Category.CategoryType.allCases.first(where: { $0.rawValue == request.query })
    }
    
    func inquiryUser(request: HomeModels.User.Request) {
        let user = FirebaseUser.shared.getUser()
        let response = HomeModels.User.Response(user: user)
        
        presenter?.presentInquiryUser(response: response)
    }
    
    // MARK: - Prepare Routing
    
    func prepareRouteToFoodDetail(food: FoodDetailModels.FoodDetailResponse) {
        self.food = food
        presenter?.presentPrepareRouteToFoodDetail()
    }
}
