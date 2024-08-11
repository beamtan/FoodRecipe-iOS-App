//
//  FoodDetailPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol FoodDetailPresentationLogic {
    func presentSomething(response: FoodDetailModels.Something.Response)
}

class FoodDetailPresenter: FoodDetailPresentationLogic {
    weak var viewController: FoodDetailDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: FoodDetailModels.Something.Response) {
        let viewModel = FoodDetailModels.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
