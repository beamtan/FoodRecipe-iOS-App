//
//  Environment.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 13/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import Foundation

struct Environment {
    static let themealdbBaseUrl: String = "https://www.themealdb.com/"
    static let spoonacularBaseUrl: String = "https://api.spoonacular.com/recipes/"
}

extension Environment {
    struct TheMealdbEndpoint {
        static let CATEGORY: String = "\(Environment.themealdbBaseUrl)api/json/v1/1/categories.php"
        static let SEARCH_BY_CATEGORY: String = "\(Environment.themealdbBaseUrl)api/json/v1/1/filter.php?c="
        static let SEARCH_BY_NAME: String = "\(Environment.themealdbBaseUrl)api/json/v1/1/search.php?s="
    }
    
    struct SpoonacularEndpoint {
        static let GET_FOODS_BY_SEARCH_QUERY: String = "\(Environment.spoonacularBaseUrl)complexSearch?"
        static let GET_RECIPE_INFO_BY_ID: (_ id: String) -> String = { id in
            return "\(Environment.spoonacularBaseUrl)\(id)/information"
        }
        static let GET_RECIPE_NUTRITION_BY_ID: (_ id: String) -> String = { id in
            return "\(Environment.spoonacularBaseUrl)\(id)/nutritionWidget.json"
        }
    }
}
