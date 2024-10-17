//
//  FirebaseUserManager.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 17/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//
protocol FirebaseUserManagerImp {
    func updateUser(editedName: String, completionHandler: @escaping ((Error?) -> ()))
}

class FirebaseUserManager: FirebaseUserManagerImp {
    var googleService: GoogleServiceImp
    
    init(googleService: GoogleServiceImp) {
        self.googleService = googleService
    }
    
    func updateUser(editedName: String, completionHandler: @escaping ((Error?) -> ())) {
        googleService.updateDisplayName(name: editedName) { [weak self] error in
            guard let self else {
                return
            }
            
            googleService.getFirebaseUser() { [weak self] user in
                guard let self else {
                    return
                }
                
                let data = FirebaseUserModel(
                    displayName: user?.displayName ?? "",
                    photoUrl: "\(user?.photoURL)",
                    email: user?.email ?? ""
                )
                
                FirebaseUser.shared.saveUser(user: data)
                
                completionHandler(error)
            }
        }
    }
}
