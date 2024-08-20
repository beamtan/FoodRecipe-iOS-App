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
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: SeeAllFoodViewController, destination: SomewhereViewController) {
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: SeeAllFoodDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
