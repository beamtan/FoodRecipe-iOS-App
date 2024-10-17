//
//  ProfileInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic {
    func logout()
}

protocol ProfileDataStore {
    
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorker?
    
    func logout() {
        let googleService = GoogleService()
        
        FirebaseUser.shared.resetUser()
        googleService.signOut()
    }
}
