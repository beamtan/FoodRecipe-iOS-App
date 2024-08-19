//
//  ProfileInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic {
    func inquiryFavouriteFoods(request: ProfileModels.InquiryFavouriteFoods.Request)
}

protocol ProfileDataStore {
    
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorker?
    
    func inquiryFavouriteFoods(request: ProfileModels.InquiryFavouriteFoods.Request) {
        let favouriteFoods = UserDefaultService.shared.getFavouriteFoods()
        let response = ProfileModels.InquiryFavouriteFoods.Response(data: favouriteFoods)
        presenter?.presentInquiryFavouriteFoods(response: response)
    }
}
