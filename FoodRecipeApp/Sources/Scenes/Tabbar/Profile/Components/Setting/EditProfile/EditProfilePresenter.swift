//
//  EditProfilePresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 17/10/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol EditProfilePresentationLogic {
    func presentInquiryUser(response: EditProfileModels.User.Response)
    func presentUpdateProfile(response: EditProfileModels.UpdateUser.Response)
}

class EditProfilePresenter: EditProfilePresentationLogic {
    weak var viewController: EditProfileDisplayLogic?
    
    func presentInquiryUser(response: EditProfileModels.User.Response) {
        let email: String = response.user?.email ?? "Anonymous"
        let displayName: String = response.user?.displayName ?? email
        
        let viewModel = EditProfileModels.User.ViewModel(email: email, displayName: displayName)
        
        viewController?.displayInquiryUser(viewModel: viewModel)
    }
    
    func presentUpdateProfile(response: EditProfileModels.UpdateUser.Response) {
        guard response.error == nil else {
            let viewModel = EditProfileModels.UpdateUser.ViewModel()
            viewController?.displayUpdateProfileFailure(viewModel: viewModel)
            
            return
        }
        
        let viewModel = EditProfileModels.UpdateUser.ViewModel()
        viewController?.displayUpdateProfileSuccess(viewModel: viewModel)
    }
}
