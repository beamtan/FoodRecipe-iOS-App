//
//  LoginInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

protocol LoginBusinessLogic {
    func loginWithFirebase(request: LoginModels.FirebaseLogin.Request)
    func saveUserToFirebaseUser(request: LoginModels.FirebaseUser.Request)
}

protocol LoginDataStore {

}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    var googleService: GoogleServiceImp?
    
    func loginWithFirebase(request: LoginModels.FirebaseLogin.Request) {
        let googleService = GoogleService()
        
        googleService.signIn(email: request.email, password: request.password) { [weak self] error in
            guard let self else { return }
            
            guard error == nil else {
                let response = LoginModels.FirebaseLogin.Response(data: nil, error: error)
                presenter?.presentLoginWithFirebase(response: response)
                
                return
            }
            
             googleService.getFirebaseUser() { [weak self] user in
                 guard let self else { return }
                 
                 let data = FirebaseUserModel(
                    displayName: user?.displayName ?? "",
                    photoUrl: "\(user?.photoURL)",
                    email: user?.email ?? ""
                 )
                 
                 let response = LoginModels.FirebaseLogin.Response(data: data, error: nil)
                 presenter?.presentLoginWithFirebase(response: response)
            }
        }
    }
    
    func saveUserToFirebaseUser(request: LoginModels.FirebaseUser.Request) {
        FirebaseUser.shared.saveUser(user: request.user)
    }
}
