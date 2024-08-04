//
//  AuthenticationPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol AuthenticationPresentationLogic {
    func presentSomething(response: AuthenticationModels.Something.Response)
}

class AuthenticationPresenter: AuthenticationPresentationLogic {
    weak var viewController: AuthenticationDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: AuthenticationModels.Something.Response) {
        let viewModel = AuthenticationModels.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
