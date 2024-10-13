//
//  SeeAllFoodWorker.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 21/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import Alamofire

protocol SeeAllFoodWorkerProtocol {
    func inquirySearchFoodsByCategory(
        request: HomeModels.InquirySearchFoodsByQueryText.Request,
        completionHandler: @escaping (
            (DataResponse<HomeModels.SearchFoodsResponse, AFError>) -> ()
        )
    )
}

class SeeAllFoodWorker: SeeAllFoodWorkerProtocol {
    func inquirySearchFoodsByCategory(
        request: HomeModels.InquirySearchFoodsByQueryText.Request,
        completionHandler: @escaping ((DataResponse<HomeModels.SearchFoodsResponse, AFError>) -> ())
    ) {
        let service = Service()
        
        service.inquirySearchFoodsByQueryText(request: request, completionHandler: completionHandler)
    }
}

class MockSeeAllFoodWorker: SeeAllFoodWorkerProtocol {
    func inquirySearchFoodsByCategory(
        request: HomeModels.InquirySearchFoodsByQueryText.Request,
        completionHandler: @escaping ((DataResponse<HomeModels.SearchFoodsResponse, AFError>) -> ())
    ) {
        let mockData = getData()
        let jsonData = try! JSONEncoder().encode(mockData)
        
        let url = URL(string: "https://example.com/api/search-foods")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        if let mockData {
            let responseData = DataResponse<HomeModels.SearchFoodsResponse, AFError>(
                request: nil,
                response: response,
                data: jsonData,
                metrics: nil,
                serializationDuration: 0,
                result: .success(mockData)
            )
            
            completionHandler(responseData)
        }
    }
    
    func getData() -> HomeModels.SearchFoodsResponse? {
        let dataFromJson = loadJson(fileName: "foods50Response", type: HomeModels.SearchFoodsResponse.self)
        return dataFromJson
    }
}
