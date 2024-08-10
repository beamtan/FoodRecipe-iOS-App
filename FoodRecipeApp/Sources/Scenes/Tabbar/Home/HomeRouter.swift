//
//  HomeRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
}
