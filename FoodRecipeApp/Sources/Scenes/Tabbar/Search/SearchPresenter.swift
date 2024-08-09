//
//  SearchPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentSomething(response: SearchModels.Something.Response)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: SearchModels.Something.Response) {
        let viewModel = SearchModels.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
