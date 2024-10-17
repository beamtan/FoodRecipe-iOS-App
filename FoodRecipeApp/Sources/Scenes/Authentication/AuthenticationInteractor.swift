//
//  AuthenticationInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol AuthenticationBusinessLogic {

}

protocol AuthenticationDataStore {
    
}

class AuthenticationInteractor: AuthenticationBusinessLogic, AuthenticationDataStore {
    var presenter: AuthenticationPresentationLogic?
    var worker: AuthenticationWorker?
}
