//
//  FoodDetailRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol FoodDetailRoutingLogic {

}

protocol FoodDetailDataPassing {
    var dataStore: FoodDetailDataStore? { get }
}

class FoodDetailRouter: NSObject, FoodDetailRoutingLogic, FoodDetailDataPassing {
    weak var viewController: FoodDetailViewController?
    var dataStore: FoodDetailDataStore?
}
