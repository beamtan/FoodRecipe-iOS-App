//
//  EditProfileInteractor.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 17/10/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol EditProfileBusinessLogic {
    func inquiryUser(request: EditProfileModels.User.Request)
    func updateUserProfile(request: EditProfileModels.UpdateUser.Request)
}

protocol EditProfileDataStore {
    
}

class EditProfileInteractor: EditProfileBusinessLogic, EditProfileDataStore {
    var presenter: EditProfilePresentationLogic?
    var worker: EditProfileWorker?
    
    var googleServiceManager = FirebaseUserManager(googleService: GoogleService())
    
    func inquiryUser(request: EditProfileModels.User.Request) {
        let user = FirebaseUser.shared.getUser()
        let response = EditProfileModels.User.Response(user: user)
        
        presenter?.presentInquiryUser(response: response)
    }
    
    func updateUserProfile(request: EditProfileModels.UpdateUser.Request) {
        googleServiceManager.updateUser(editedName: request.displayName) { [weak self] error in
            guard let self else { return }
            
            let response = EditProfileModels.UpdateUser.Response(error: error)
            presenter?.presentUpdateProfile(response: response)
        }
    }
}
