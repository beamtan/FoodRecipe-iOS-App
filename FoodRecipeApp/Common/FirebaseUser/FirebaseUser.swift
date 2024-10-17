//
//  FirebaseUser.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 17/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

class FirebaseUser {
    static let shared = FirebaseUser()
    
    private var user: FirebaseUserModel? = nil
    
    func getUser() -> FirebaseUserModel? {
        return user
    }
    
    func saveUser(user: FirebaseUserModel) {
        self.user = user
    }
    
    func resetUser() {
        user = nil
    }
}
