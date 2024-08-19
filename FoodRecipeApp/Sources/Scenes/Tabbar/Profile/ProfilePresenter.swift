//
//  ProfilePresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic {
    func presentInquiryFavouriteFoods(response: ProfileModels.InquiryFavouriteFoods.Response)
}

class ProfilePresenter: ProfilePresentationLogic {
    weak var viewController: ProfileDisplayLogic?
    
    func presentInquiryFavouriteFoods(response: ProfileModels.InquiryFavouriteFoods.Response) {
        let viewModel = ProfileModels.InquiryFavouriteFoods.ViewModel(data: response.data)
        viewController?.displayInquiryFavouriteFoods(viewModel: viewModel)
    }
}
