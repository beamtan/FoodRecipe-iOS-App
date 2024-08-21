//
//  SeeAllFoodRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 21/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol SeeAllFoodRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol SeeAllFoodDataPassing {
    var dataStore: SeeAllFoodDataStore? { get }
}

class SeeAllFoodRouter: NSObject, SeeAllFoodRoutingLogic, SeeAllFoodDataPassing {
    weak var viewController: SeeAllFoodViewController?
    var dataStore: SeeAllFoodDataStore?
}
