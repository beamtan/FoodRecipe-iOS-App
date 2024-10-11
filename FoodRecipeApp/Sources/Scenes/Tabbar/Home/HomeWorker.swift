//
//  HomeWorker.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import Alamofire

protocol HomeWorkerProtocol {
    // MARK: - Call Service
    
    func inquirySearchFoodsByCategory(
        request: HomeModels.InquirySearchFoodsByCategory.Request,
        completionHandler: @escaping (
            (DataResponse<HomeModels.SearchFoodsResponse, AFError>) -> ()
        )
    )
}

class HomeWorker: HomeWorkerProtocol {
    func inquirySearchFoodsByCategory(
        request: HomeModels.InquirySearchFoodsByCategory.Request,
        completionHandler: @escaping ((DataResponse<HomeModels.SearchFoodsResponse, AFError>) -> ())
    ) {
        let service = Service()
        
        service.inquirySearchFoodsByCategory(request: request, completionHandler: completionHandler)
    }
}

// MARK: - Mock Data

class MockHomeWorker: HomeWorkerProtocol {
    func inquirySearchFoodsByCategory(
        request: HomeModels.InquirySearchFoodsByCategory.Request,
        completionHandler: @escaping ((DataResponse<HomeModels.SearchFoodsResponse, AFError>) -> ())
    ) {
        let mockData = getData(category: request.category)
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
    
    func getData(category: String) -> HomeModels.SearchFoodsResponse? {
        let categoryType = getCategory(category: category)
        
        let fileName: String = {
            switch categoryType {
            case .mainCourse:
                return "mainCourseTop6Response"
            case .sideDish:
                return "sideDishTop6Response"
            case .dessert:
                return "dessertTop6Response"
            case .appetizer:
                return "appetizerTop6Response"
            case .salad:
                return "saladTop6Response"
            case .bread:
                return "breadTop6Response"
            case .breakfast:
                return "breakfastTop6Response"
            case .soup:
                return "soupTop6Response"
            case .beverage:
                return "beverageTop6Response"
            case .sauce:
                return "sauceTop6Response"
            case .marinade:
                return "marinadeTop6Response"
            case .fingerFood:
                return "fingerfoodTop6Response"
            case .snack:
                return "snackTop6Response"
            case .drink:
                return "drinkTop6Response"
            }
        }()
        
        let dataFromJson = loadJson(fileName: fileName, type: HomeModels.SearchFoodsResponse.self)
        return dataFromJson
    }
    
    func getCategory(category: String) -> HomeModels.Category.CategoryType {
        let category = HomeModels.Category.CategoryType.allCases.first(where: { $0.rawValue == category })
        return category ?? .mainCourse
    }
}
