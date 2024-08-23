//
//  LoginInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol LoginBusinessLogic {
    func doSomething(request: LoginModels.Something.Request)
}

protocol LoginDataStore {
    //var name: String { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: LoginModels.Something.Request) {
        worker = LoginWorker()
        
        let response = LoginModels.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
