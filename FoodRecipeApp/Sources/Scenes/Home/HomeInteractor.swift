//
//  HomeInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func doSomething(request: HomeModels.Something.Request)
}

protocol HomeDataStore {
    //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: HomeModels.Something.Request) {
        worker = HomeWorker()
        worker?.doSomeWork()
        
        let response = HomeModels.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
