//
//  LoginInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol LoginBusinessLogic {
    func loginWithFirebase(request: LoginModels.FirebaseLogin.Request)
}

protocol LoginDataStore {

}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    
    var googleServiceManager = FirebaseUserManager(googleService: GoogleService())
    
    func loginWithFirebase(request: LoginModels.FirebaseLogin.Request) {
        googleServiceManager.signInWithEmailAndSaveUser(email: request.email, password: request.password) { [weak self] error in
            guard let self else { return }
            
            let response = LoginModels.FirebaseLogin.Response(error: error)
            presenter?.presentLoginWithFirebase(response: response)
        }
    }
}
