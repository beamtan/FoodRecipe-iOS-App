//
//  EditProfileModels.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 17/10/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

struct EditProfileModels {
    
    struct User {
        struct Request {
        }
        
        struct Response {
            let user: FirebaseUserModel?
        }
        
        struct ViewModel {
            let email: String
            let displayName: String
        }
    }
    
    struct UpdateUser {
        struct Request {
            let displayName: String
        }
        
        struct Response {
            let error: Error?
        }
        
        struct ViewModel {
        }
    }
}
