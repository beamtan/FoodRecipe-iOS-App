//
//  FirebaseUserManager.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 17/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//
import FirebaseAuth
import UIKit

protocol FirebaseUserManagerImp {
    func signInWithEmailAndSaveUser(email: String, password: String, completionHandler: @escaping ((Error?) -> ()))
    func signInWithGoogleAccount(viewController: UIViewController, completionHandler: @escaping ((Error?) -> ()))
    
    func updateUser(editedName: String, completionHandler: @escaping ((Error?) -> ()))
    func updateEmail(editedEmail: String, completionHandler: @escaping ((Error?) -> ()))
    
    func createUserWithEmailAndSaveUser(email: String, password: String, completionHandler: @escaping ((Error?) -> ()))
    
    func logout()
}

class FirebaseUserManager: FirebaseUserManagerImp {
    var googleService: GoogleServiceImp
    
    init(googleService: GoogleServiceImp) {
        self.googleService = googleService
    }
    
    func saveUser(user: User?) {
        let data = FirebaseUserModel(
            displayName: user?.displayName,
            photoUrl: String(describing: user?.photoURL),
            email: user?.email
        )
        
        FirebaseUser.shared.saveUser(user: data)
    }
    
    // MARK: - CRUD
    
    func signInWithGoogleAccount(viewController: UIViewController, completionHandler: @escaping ((Error?) -> ())) {
        googleService.signUp(viewController: viewController) { [weak self] error in
            guard let self else {
                return
            }
            
            googleService.getFirebaseUser() { [weak self] user in
                guard let self else {
                    return
                }
                
                if error == nil {
                    saveUser(user: user)
                }
                
                completionHandler(error)
            }
        }
    }
    
    func signInWithEmailAndSaveUser(
        email: String,
        password: String,
        completionHandler: @escaping ((Error?) -> ()
        )
    ) {
        googleService.signIn(email: email, password: password) { [weak self] error in
            guard let self else {
                return
            }
                
            googleService.getFirebaseUser() { [weak self] user in
                guard let self else {
                    return
                }
                
                if error == nil {
                    saveUser(user: user)
                }
                
                completionHandler(error)
            }
        }
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
                
                if error == nil {
                    saveUser(user: user)
                }
                
                completionHandler(error)
            }
        }
    }
    
    func updateEmail(
        editedEmail: String,
        completionHandler: @escaping (((any Error)?) -> ())
    ) {
        googleService.updateEmail(email: editedEmail) { [weak self] error in
            guard let self else {
                return
            }
            
            googleService.getFirebaseUser() { [weak self] user in
                guard let self else {
                    return
                }
                
                if error == nil {
                    saveUser(user: user)
                }
                
                completionHandler(error)
            }
        }
    }
    
    func createUserWithEmailAndSaveUser(
        email: String,
        password: String,
        completionHandler: @escaping (((any Error)?) -> ())
    ) {
        googleService.createUser(email: email, password: password) { [weak self] error in
            guard let self else {
                return
            }
            
            googleService.getFirebaseUser() { [weak self] user in
                guard let self else {
                    return
                }
                
                if error == nil {
                    saveUser(user: user)
                }
                
                completionHandler(error)
            }
        }
    }
    
    func logout() {
        FirebaseUser.shared.resetUser()
        googleService.signOut()
    }
}
