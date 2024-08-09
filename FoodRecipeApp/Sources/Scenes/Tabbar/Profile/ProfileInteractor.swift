//
//  ProfileInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic {
    func doSomething(request: ProfileModels.Something.Request)
}

protocol ProfileDataStore {
    //var name: String { get set }
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: ProfileModels.Something.Request) {
        worker = ProfileWorker()
        worker?.doSomeWork()
        
        let response = ProfileModels.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
