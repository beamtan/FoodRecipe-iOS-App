//
//  LoginModels.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

struct LoginModels {
    struct FirebaseLogin {
        struct Request {
            let email: String
            let password: String
        }
        
        struct Response {
            let error: Error?
        }
        
        struct ViewModel {
            var message: String = ""
        }
    }
}
