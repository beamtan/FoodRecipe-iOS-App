//
//  SearchInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func doSomething(request: SearchModels.Something.Request)
}

protocol SearchDataStore {
    //var name: String { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    var presenter: SearchPresentationLogic?
    var worker: SearchWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: SearchModels.Something.Request) {
        worker = SearchWorker()
        worker?.doSomeWork()
        
        let response = SearchModels.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
