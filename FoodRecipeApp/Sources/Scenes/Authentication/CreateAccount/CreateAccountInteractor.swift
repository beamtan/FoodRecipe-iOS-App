//
//  CreateAccountInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol CreateAccountBusinessLogic {
    func createUserWithFirebase(request: CreateAccountModels.FirebaseCreateUser.Request)
}

protocol CreateAccountDataStore {
    
}

class CreateAccountInteractor: CreateAccountBusinessLogic, CreateAccountDataStore {
    var presenter: CreateAccountPresentationLogic?
    var worker: CreateAccountWorker?

    var googleServiceManager = FirebaseUserManager(googleService: GoogleService())
    
    func createUserWithFirebase(request: CreateAccountModels.FirebaseCreateUser.Request) {
        googleServiceManager.createUserWithEmailAndSaveUser(
            email: request.email,
            password: request.password
        ) { [weak self] error in
            guard let self else { return }
            
            let response = CreateAccountModels.FirebaseCreateUser.Response(error: error)
            presenter?.presentCreateUserWithFirebase(response: response)
        }
    }
}
