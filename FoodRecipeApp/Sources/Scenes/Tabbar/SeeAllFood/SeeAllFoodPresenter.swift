//
//  SeeAllFoodPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 21/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SeeAllFoodPresentationLogic {
    func presentSomething(response: SeeAllFoodModels.Something.Response)
}

class SeeAllFoodPresenter: SeeAllFoodPresentationLogic {
    weak var viewController: SeeAllFoodDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: SeeAllFoodModels.Something.Response) {
        let viewModel = SeeAllFoodModels.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
