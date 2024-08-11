//
//  FoodDetailInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol FoodDetailBusinessLogic {
    func doSomething(request: FoodDetailModels.Something.Request)
}

protocol FoodDetailDataStore {
    //var name: String { get set }
}

class FoodDetailInteractor: FoodDetailBusinessLogic, FoodDetailDataStore {
    var presenter: FoodDetailPresentationLogic?
    var worker: FoodDetailWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: FoodDetailModels.Something.Request) {
        worker = FoodDetailWorker()
        worker?.doSomeWork()
        
        let response = FoodDetailModels.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
