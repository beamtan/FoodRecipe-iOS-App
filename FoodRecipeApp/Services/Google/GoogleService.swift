//
//  GoogleService.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 6/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

protocol GoogleServiceImp {
    func createUser(email: String, password: String, completionHandler: @escaping ((Error?) -> ()))
    func signUp(viewController: UIViewController, completionHandler: @escaping ((Error?) -> ()))
    func signIn(credential: AuthCredential, completionHandler: @escaping (() -> ()))
    func signIn(email: String, password: String, completionHandler: @escaping ((Error?) -> ()))
    func signOut()
    
    func getFirebaseUser(completionHandler: @escaping ((FirebaseAuth.User?) -> ()))
    
    func updateDisplayName(name: String, completionHandler: @escaping ((Error?) -> ()))
    func updateEmail(email: String, completionHandler: @escaping ((Error?) -> ()))
}

class GoogleService: GoogleServiceImp {
    func createUser(email: String, password: String, completionHandler: @escaping ((Error?) -> ())) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completionHandler(error)
        }
    }
    
    // MARK: - Google Sign in
    
    func signUp(viewController: UIViewController, completionHandler: @escaping ((Error?) -> ())) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            return
        }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [unowned self] result, error in
            guard error == nil else {
                print("Error signUp: \(String(describing: error))")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            signIn(credential: credential) {
                completionHandler(error)
            }
        }
    }
    
    
    
    func signIn(credential: AuthCredential, completionHandler: @escaping (()->())) {
        Auth.auth().signIn(with: credential) { result, error in
            if error != nil {
                print("Error signIn: \(String(describing: error))")
                return
            }
            
            completionHandler()
        }
    }
    
    // MARK: - Email Sign in
    
    func signIn(
        email: String,
        password: String,
        completionHandler: @escaping ((Error?) -> ()
        )
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else {
                return
            }
            
            if error != nil {
                print("Error signIn: \(String(describing: error))")
                completionHandler(error)
                
                return
            }
            
            completionHandler(error)
        }
    }
    
    // MARK: - Life Cycle
    
    func getFirebaseUser(completionHandler: @escaping ((FirebaseAuth.User?) -> ())) {
        let user = Auth.auth().currentUser
        
        if let user = user {
            completionHandler(user)
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    // MARK: - Update
    
    func updateDisplayName(name: String, completionHandler: @escaping ((Error?) -> ())) {
        let user = Auth.auth().currentUser
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { [weak self] (error) in
                guard let self else { return }
                
                completionHandler(error)
            }
        }
    }
    
    func updateEmail(email: String, completionHandler: @escaping (((any Error)?) -> ())) {
        let user = Auth.auth().currentUser
        if let user = user {
            user.updateEmail(to: email) { [weak self] (error) in
                guard let self else { return }
                
                completionHandler(error)
            }
        }
    }
}
