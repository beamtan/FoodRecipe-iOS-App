//
//  LoginPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol LoginPresentationLogic {
    func presentSomething(response: LoginModels.Something.Response)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: LoginModels.Something.Response) {
        let viewModel = LoginModels.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
