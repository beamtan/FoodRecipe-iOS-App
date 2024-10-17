//
//  AuthenticationRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol AuthenticationRoutingLogic {
    
}

protocol AuthenticationDataPassing {
    var dataStore: AuthenticationDataStore? { get }
}

class AuthenticationRouter: NSObject, AuthenticationRoutingLogic, AuthenticationDataPassing {
    weak var viewController: AuthenticationViewController?
    var dataStore: AuthenticationDataStore?
}
