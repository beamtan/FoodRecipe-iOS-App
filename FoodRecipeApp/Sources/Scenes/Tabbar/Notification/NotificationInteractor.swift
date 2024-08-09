//
//  NotificationInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol NotificationBusinessLogic {
    func doSomething(request: NotificationModels.Something.Request)
}

protocol NotificationDataStore {
    //var name: String { get set }
}

class NotificationInteractor: NotificationBusinessLogic, NotificationDataStore {
    var presenter: NotificationPresentationLogic?
    var worker: NotificationWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: NotificationModels.Something.Request) {
        worker = NotificationWorker()
        worker?.doSomeWork()
        
        let response = NotificationModels.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
