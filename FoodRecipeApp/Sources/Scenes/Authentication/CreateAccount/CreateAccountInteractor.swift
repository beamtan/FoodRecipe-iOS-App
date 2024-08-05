//
//  CreateAccountInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol CreateAccountBusinessLogic {
    
}

protocol CreateAccountDataStore {
    
}

class CreateAccountInteractor: CreateAccountBusinessLogic, CreateAccountDataStore {
    var presenter: CreateAccountPresentationLogic?
    var worker: CreateAccountWorker?

}
