//
//  CreateAccountRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol CreateAccountRoutingLogic {
    
}

protocol CreateAccountDataPassing {
    var dataStore: CreateAccountDataStore? { get }
}

class CreateAccountRouter: NSObject, CreateAccountRoutingLogic, CreateAccountDataPassing {
    weak var viewController: CreateAccountViewController?
    var dataStore: CreateAccountDataStore?
}
