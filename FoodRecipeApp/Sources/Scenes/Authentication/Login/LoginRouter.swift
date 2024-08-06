//
//  LoginRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol LoginRoutingLogic {
    func routeToHome()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    // MARK: Routing
    
    func routeToHome() {
        guard let destination = UIStoryboard(name: "HomeStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController,
              let viewController else { return }
        
        navigateToHome(source: viewController, destination: destination)
    }
    
    // MARK: Navigation
    
    func navigateToHome(source: LoginViewController, destination: HomeViewController) {
        destination.modalPresentationStyle = .fullScreen
        source.present(destination, animated: true)
    }
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: LoginDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
