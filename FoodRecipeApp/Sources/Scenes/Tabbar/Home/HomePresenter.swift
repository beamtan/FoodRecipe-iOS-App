//
//  HomePresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentSomething(response: HomeModels.Something.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: HomeModels.Something.Response) {
        let viewModel = HomeModels.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
