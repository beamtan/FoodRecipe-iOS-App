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
    func inquiryFoodCategories(completionHandler: @escaping (DataResponse<HomeModels.WelcomeResponse, AFError>) -> ())
    func inquirySearchFoodsByCategory(request: HomeModels.InquirySearchFoodsByCategory.Request, completionHandler: @escaping (DataResponse<HomeModels.MealsResponse, AFError>) -> ())
}

class Service: ServiceProtocol {
    private let httpClient: HttpClient
    
    init(client: HttpClient = HttpClient()) {
        self.httpClient = client
    }
    
    func inquiryFoodCategories(completionHandler: @escaping (DataResponse<HomeModels.WelcomeResponse, AFError>) -> ()) {
        let url = String(format: Environment.Endpoint.CATEGORY)
        httpClient.request(url, method: .get, completionHandler: completionHandler)
    }
    
    func inquirySearchFoodsByCategory(request: HomeModels.InquirySearchFoodsByCategory.Request, completionHandler: @escaping (DataResponse<HomeModels.MealsResponse, AFError>) -> ()) {
        let url = String(format: Environment.Endpoint.SEARCH_BY_CATEGORY + request.category)
        httpClient.request(url, method: .get, completionHandler: completionHandler)
    }
}
