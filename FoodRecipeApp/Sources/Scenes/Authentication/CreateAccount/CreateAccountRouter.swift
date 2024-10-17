//
//  CreateAccountRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol CreateAccountRoutingLogic {
    func routeToHome()
    func routeToGoogleLogin()
}

protocol CreateAccountDataPassing {
    var dataStore: CreateAccountDataStore? { get }
}

class CreateAccountRouter: NSObject, CreateAccountRoutingLogic, CreateAccountDataPassing {
    weak var viewController: CreateAccountViewController?
    var dataStore: CreateAccountDataStore?
    
    var googleServiceManager = FirebaseUserManager(googleService: GoogleService())
    
    // MARK: Routing
    
    func routeToHome() {
        guard let destination = UIStoryboard(name: "HomeTabbarStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "HomeTabbarViewController") as? HomeTabbarViewController,
              let viewController else { return }
        
        navigateToHome(source: viewController, destination: destination)
    }
    
    func routeToGoogleLogin() {
        guard let viewController else {
            return
        }
        
        googleServiceManager.signInWithGoogleAccount(viewController: viewController) { [weak self] error in
            guard let self else { return }
            
            if error == nil {
                routeToHome()
            }
        }
    }
    
    // MARK: Navigation
    
    func navigateToHome(source: CreateAccountViewController, destination: HomeTabbarViewController) {
        let navigationController = UINavigationController(rootViewController: destination)
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc: navigationController, animation: .transitionFlipFromLeft)
    }
    
    // MARK: Passing data
}
