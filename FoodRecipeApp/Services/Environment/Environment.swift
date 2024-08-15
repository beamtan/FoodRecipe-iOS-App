//
//  Environment.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 13/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import Foundation

struct Environment {
    static let baseUrl: String = "https://www.themealdb.com/"
}

extension Environment {
    struct Endpoint {
        static let CATEGORY: String = "\(Environment.baseUrl)api/json/v1/1/categories.php"
        static let SEARCH_BY_CATEGORY: String = "\(Environment.baseUrl)api/json/v1/1/filter.php?c="
        static let SEARCH_BY_NAME: String = "\(Environment.baseUrl)api/json/v1/1/search.php?s="
    }
}
