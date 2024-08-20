//
//  SeeAllFoodInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 21/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SeeAllFoodBusinessLogic {
    func doSomething(request: SeeAllFoodModels.Something.Request)
}

protocol SeeAllFoodDataStore {
    //var name: String { get set }
}

class SeeAllFoodInteractor: SeeAllFoodBusinessLogic, SeeAllFoodDataStore {
    var presenter: SeeAllFoodPresentationLogic?
    var worker: SeeAllFoodWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: SeeAllFoodModels.Something.Request) {
        worker = SeeAllFoodWorker()
        worker?.doSomeWork()
        
        let response = SeeAllFoodModels.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
