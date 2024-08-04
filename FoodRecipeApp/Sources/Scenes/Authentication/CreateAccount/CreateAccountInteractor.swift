//
//  CreateAccountInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol CreateAccountBusinessLogic {
    func doSomething(request: CreateAccountModels.Something.Request)
}

protocol CreateAccountDataStore {
    //var name: String { get set }
}

class CreateAccountInteractor: CreateAccountBusinessLogic, CreateAccountDataStore {
    var presenter: CreateAccountPresentationLogic?
    var worker: CreateAccountWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: CreateAccountModels.Something.Request) {
        worker = CreateAccountWorker()
        worker?.doSomeWork()
        
        let response = CreateAccountModels.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
