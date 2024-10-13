//
//  SearchInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func inquirySearchFoodsByQuery(request: HomeModels.InquirySearchFoodsByQueryText.Request)
    
    /// Route
    func prepareRouteToFoodDetail(food: FoodDetailModels.FoodDetailResponse)
}

protocol SearchDataStore {
    var food: FoodDetailModels.FoodDetailResponse? { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    var presenter: SearchPresentationLogic?
    var worker: HomeWorkerProtocol?
    
    var food: FoodDetailModels.FoodDetailResponse?
    
    func inquirySearchFoodsByQuery(request: HomeModels.InquirySearchFoodsByQueryText.Request) {
        worker = SearchWorker()
        
        worker?.inquirySearchFoodsByQuery(request: request) { [weak self] (data) in
            guard let self else { return }
            
            switch data.result {
            case .success(let response):
                let response = HomeModels.InquirySearchFoodsByQueryText.Response(data: response, error: nil)
                presenter?.presentSearchFoodsByQuery(response: response)
            case .failure(let error):
                let response = HomeModels.InquirySearchFoodsByQueryText.Response(data: nil, error: error)
                presenter?.presentSearchFoodsByQuery(response: response)
            }
        }
    }
    
    // MARK: - Prepare Routing
    
    func prepareRouteToFoodDetail(food: FoodDetailModels.FoodDetailResponse) {
        self.food = food
        presenter?.presentPrepareRouteToFoodDetail()
    }
}
