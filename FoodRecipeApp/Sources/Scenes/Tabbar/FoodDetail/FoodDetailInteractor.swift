//
//  FoodDetailInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol FoodDetailBusinessLogic {
    func inquiryFoodDetail()
    func inquiryFoodNutrition()
}

protocol FoodDetailDataStore {
    var id: String { get set }
}

class FoodDetailInteractor: FoodDetailBusinessLogic, FoodDetailDataStore {
    var presenter: FoodDetailPresentationLogic?
    var worker: FoodDetailWorker?
    
    var id: String = ""
    
    func inquiryFoodDetail() {
        let service = Service()
        let worker = FoodDetailWorker()
        let request = FoodDetailModels.InquiryFoodDetail.Request(id: id)
        
        service.inquiryFoodDetail(request: request) { [weak self] (data) in
            guard let self else { return }
            
            switch data.result {
            case .success(let response):
                let properResponse = worker.constructProperFoodDetailResponse(response: response)
                let responsePresenter = FoodDetailModels.InquiryFoodDetail.Response(data: properResponse, error: nil)
                presenter?.presentInquiryFoodDetail(response: responsePresenter)
            case .failure(let error):
                let response = FoodDetailModels.InquiryFoodDetail.Response(data: nil, error: error)
                presenter?.presentInquiryFoodDetail(response: response)
            }
        }
    }
    
    func inquiryFoodNutrition() {
        let service = Service()
        let request = FoodDetailModels.InquiryFoodNutrition.Request(id: id)
        
        service.inquiryFoodNutrition(request: request) { [weak self] (data) in
            guard let self else { return }
            
            switch data.result {
            case .success(let response):
                let response = FoodDetailModels.InquiryFoodNutrition.Response(data: response, error: nil)
                presenter?.presentInquiryFoodNutrition(response: response)
            case .failure(let error):
                let response = FoodDetailModels.InquiryFoodNutrition.Response(data: nil, error: error)
                presenter?.presentInquiryFoodNutrition(response: response)
            }
        }
    }
}
