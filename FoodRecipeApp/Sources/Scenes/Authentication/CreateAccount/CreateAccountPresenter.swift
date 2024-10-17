//
//  CreateAccountPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol CreateAccountPresentationLogic {
    func presentCreateUserWithFirebase(response: CreateAccountModels.FirebaseCreateUser.Response)
}

class CreateAccountPresenter: CreateAccountPresentationLogic {
    weak var viewController: CreateAccountDisplayLogic?
    
    func presentCreateUserWithFirebase(response: CreateAccountModels.FirebaseCreateUser.Response) {
        guard response.error == nil else {
            let viewModel = CreateAccountModels.FirebaseCreateUser.ViewModel(
                message: response.error?.localizedDescription ?? ""
            )
            
            viewController?.displayCreateUserWithFirebaseFailure(viewModel: viewModel)
            
            return
        }
        
        let viewModel = CreateAccountModels.FirebaseCreateUser.ViewModel()
        viewController?.displayCreateUserWithFirebaseSuccess(viewModel: viewModel)
    }
}
