//
//  Service.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 15/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import Foundation
import Alamofire

protocol ServiceProtocol {
    func inquirySearchFoodsByCategory(
        request: HomeModels.InquirySearchFoodsByCategory.Request,
        completionHandler: @escaping (DataResponse<HomeModels.SearchFoodsResponse, AFError>) -> ()
    )
    func inquiryFoodDetail(
        request: FoodDetailModels.InquiryFoodDetail.Request,
        completionHandler: @escaping (DataResponse<FoodDetailModels.FoodDetailResponse, AFError>) -> ()
    )
    func inquiryFoodNutrition(
        request: FoodDetailModels.InquiryFoodNutrition.Request,
        completionHandler: @escaping (DataResponse<FoodDetailModels.FoodNutritionResponse, AFError>) -> ()
    )
}

class Service: ServiceProtocol {
    private let httpClient: HttpClient
    
    init(client: HttpClient = HttpClient()) {
        self.httpClient = client
    }
    
    // MARK: - Home
    
    func inquirySearchFoodsByCategory(
        request: HomeModels.InquirySearchFoodsByCategory.Request,
        completionHandler: @escaping (
            DataResponse<
            HomeModels.SearchFoodsResponse,
            AFError
            >
        ) -> ()
    ) {
        var components = URLComponents(string: Environment.SpoonacularEndpoint.GET_FOODS_BY_CATEGORY)
        components?.queryItems = [
            URLQueryItem(name: "query", value: request.category),
            URLQueryItem(name: "number", value: "\(request.number)"),
            URLQueryItem(name: "addRecipeNutrition", value: true.string),
            URLQueryItem(name: "sort", value: "popularity"),
            URLQueryItem(name: "sortDirection", value: "desc"),
        ]
        
        let urlString = components?.url?.absoluteString ?? ""
        
        httpClient.request(
            urlString,
            method: .get,
            interceptor: self,
            completionHandler: completionHandler
        )
    }
    
    // MARK: - Food Detail
    
    func inquiryFoodDetail(
        request: FoodDetailModels.InquiryFoodDetail.Request,
        completionHandler: @escaping (
            DataResponse<
            FoodDetailModels.FoodDetailResponse,
            AFError
            >
        ) -> ()
    ) {
        var components = URLComponents(string: Environment.SpoonacularEndpoint.GET_RECIPE_INFO_BY_ID(request.id))
        components?.queryItems = [
            URLQueryItem(name: "includeNutrition", value: true.string),
        ]
        
        let urlString = components?.url?.absoluteString ?? ""
        
        httpClient.request(
            urlString,
            method: .get,
            interceptor: self,
            completionHandler: completionHandler
        )
    }
    
    func inquiryFoodNutrition(
        request: FoodDetailModels.InquiryFoodNutrition.Request,
        completionHandler: @escaping (
            DataResponse<
            FoodDetailModels.FoodNutritionResponse,
            AFError
            >
        ) -> ()
    ) {
        let urlString = Environment.SpoonacularEndpoint.GET_RECIPE_NUTRITION_BY_ID(request.id)
        httpClient.request(
            urlString,
            method: .get,
            interceptor: self,
            completionHandler: completionHandler
        )
    }
}

extension Service: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        var apiKey: String = ""
        
        if let keyDictionary = Bundle.main.infoDictionary, let key = keyDictionary["ApiKey"] as? String {
            apiKey = key
        }
        
        request.headers.add(name: "x-api-key", value: "\(apiKey)")
        
        print("urlRequest: ---> \(String(describing: request.url))")
        print("METHOD: ---> \(String(describing: request.httpMethod))")
        print("Headers: ---> \(request.headers.dictionary)")
        
        completion(.success(request))
    }
}
