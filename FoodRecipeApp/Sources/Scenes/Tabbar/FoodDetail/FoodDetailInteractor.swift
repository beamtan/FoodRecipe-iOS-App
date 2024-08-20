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
}

protocol FoodDetailDataStore {
    var food: FoodDetailModels.FoodDetailResponse? { get set }
}

class FoodDetailInteractor: FoodDetailBusinessLogic, FoodDetailDataStore {
    var presenter: FoodDetailPresentationLogic?
    var worker: FoodDetailWorker?
    
    var food: FoodDetailModels.FoodDetailResponse?
    
    func inquiryFoodDetail() {
        guard let food else { return }
        
        let worker = FoodDetailWorker()
        let properResponse = worker.constructProperFoodDetailResponse(response: food)
        let responsePresenter = FoodDetailModels.InquiryFoodDetail.Response(data: properResponse, error: nil)
        presenter?.presentInquiryFoodDetail(response: responsePresenter)
    }
}
