//
//  CreateAccountPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol CreateAccountPresentationLogic {
    func presentSomething(response: CreateAccountModels.Something.Response)
}

class CreateAccountPresenter: CreateAccountPresentationLogic {
    weak var viewController: CreateAccountDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: CreateAccountModels.Something.Response) {
        let viewModel = CreateAccountModels.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
