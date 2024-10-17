//
//  SeeAllFoodRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 21/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol SeeAllFoodRoutingLogic {
    func routeToFoodDetail()
}

protocol SeeAllFoodDataPassing {
    var dataStore: SeeAllFoodDataStore? { get }
}

class SeeAllFoodRouter: NSObject, SeeAllFoodRoutingLogic, SeeAllFoodDataPassing {
    weak var viewController: SeeAllFoodViewController?
    var dataStore: SeeAllFoodDataStore?
    
    func routeToFoodDetail() {
        guard let destination = UIStoryboard(name: "FoodDetailStoryboard", bundle: nil).instantiateViewController(withIdentifier: "FoodDetailViewController") as? FoodDetailViewController else { return }
        
        guard let viewController,
              let dataStore,
              var destinationDataStore = destination.router?.dataStore else {
            return
        }
        
        passDataToFoodDetailViewController(source: dataStore, destination: &destinationDataStore)
        navigateToFoodDetail(source: viewController, destination: destination)
    }
    
    // MARK: Navigation
    
    func navigateToFoodDetail(source: SeeAllFoodViewController, destination: FoodDetailViewController) {
        destination.modalPresentationStyle = .overFullScreen
        source.present(destination, animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToFoodDetailViewController(source: SeeAllFoodDataStore, destination: inout FoodDetailDataStore) {
        destination.food = source.food
    }
}
