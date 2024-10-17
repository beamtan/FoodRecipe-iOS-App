//
//  LoginPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol LoginPresentationLogic {
    func presentLoginWithFirebase(response: LoginModels.FirebaseLogin.Response)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    func presentLoginWithFirebase(response: LoginModels.FirebaseLogin.Response) {
        guard response.error == nil else {
            let viewModel = LoginModels.FirebaseLogin.ViewModel(
                data: nil,
                message: response.error?.localizedDescription ?? ""
            )
            
            viewController?.displayLoginWithFirebaseFailure(viewModel: viewModel)
            
            return
        }
        
        let viewModel = LoginModels.FirebaseLogin.ViewModel(data: response.data)
        viewController?.displayLoginWithFirebaseSuccess(viewModel: viewModel)
    }
}
