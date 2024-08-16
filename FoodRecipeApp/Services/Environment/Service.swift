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
    func inquirySearchFoodsByCategory(request: HomeModels.InquirySearchFoodsByCategory.Request, completionHandler: @escaping (DataResponse<HomeModels.SearchFoodsResponse, AFError>) -> ())
}

class Service: ServiceProtocol {
    private let httpClient: HttpClient
    
    init(client: HttpClient = HttpClient()) {
        self.httpClient = client
    }
    
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
        ]
        
        let urlString = components?.url?.absoluteString ?? ""
        
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
        
        request.headers.add(name: "x-api-key", value: "6b4c126501ed4284855f54d3c7055e58")
        
        print("urlRequest: ---> \(String(describing: request.url))")
        print("METHOD: ---> \(String(describing: request.httpMethod))")
        print("Headers: ---> \(request.headers.dictionary)")
        
        completion(.success(request))
    }
}
