//
//  ProfileRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol ProfileRoutingLogic {
    func routeToLogin()
    func routeToEditProfile()
}

protocol ProfileDataPassing {
    var dataStore: ProfileDataStore? { get }
}

class ProfileRouter: NSObject, ProfileRoutingLogic, ProfileDataPassing {
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
    
    // MARK: Routing
    
    func routeToLogin() {
        guard let destination = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MainViewController") as? MainViewController,
              let viewController else { return }
        
        navigateToLogin(source: viewController, destination: destination)
    }
    
    func routeToEditProfile() {
        guard let destination = UIStoryboard(name: "EditProfileStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController,
              let viewController else { return }
        
        navigateToEditProfile(source: viewController, destination: destination)
    }
    
    // MARK: Navigation
    
    func navigateToLogin(source: ProfileViewController, destination: MainViewController) {
        let navigationController = UINavigationController(rootViewController: destination)
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc: navigationController, animation: .transitionFlipFromRight)
    }
    
    func navigateToEditProfile(source: ProfileViewController, destination: EditProfileViewController) {
        if let navigationController = source.navigationController {
            navigationController.pushViewController(destination, animated: true)
        }
    }
}
