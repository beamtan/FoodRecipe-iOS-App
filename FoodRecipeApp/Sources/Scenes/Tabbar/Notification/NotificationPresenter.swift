//
//  NotificationPresenter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol NotificationPresentationLogic {
    func presentSomething(response: NotificationModels.Something.Response)
}

class NotificationPresenter: NotificationPresentationLogic {
    weak var viewController: NotificationDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: NotificationModels.Something.Response) {
        let viewModel = NotificationModels.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
