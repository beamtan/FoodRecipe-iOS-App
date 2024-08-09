//
//  ProfilePresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic {
    func presentSomething(response: ProfileModels.Something.Response)
}

class ProfilePresenter: ProfilePresentationLogic {
    weak var viewController: ProfileDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: ProfileModels.Something.Response) {
        let viewModel = ProfileModels.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
