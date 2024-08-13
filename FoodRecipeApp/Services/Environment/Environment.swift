//
//  Environment.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 13/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import Foundation

struct Environment {
    var baseUrl: String {
        return "https://www.themealdb.com/"
    }
}

extension Environment {
    enum Endpoint {
        static let searchByname: String = "api/json/v1/1/search.php?s="
    }
}
