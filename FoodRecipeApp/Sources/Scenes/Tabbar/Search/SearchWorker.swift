//
//  SearchWorker.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import Alamofire

class SearchWorker: HomeWorkerProtocol {
    func inquirySearchFoodsByQuery(
        request: HomeModels.InquirySearchFoodsByQueryText.Request,
        completionHandler: @escaping ((DataResponse<HomeModels.SearchFoodsResponse, AFError>) -> ())
    ) {
        let service = Service()
        
        service.inquirySearchFoodsByQueryText(request: request, completionHandler: completionHandler)
    }
}
