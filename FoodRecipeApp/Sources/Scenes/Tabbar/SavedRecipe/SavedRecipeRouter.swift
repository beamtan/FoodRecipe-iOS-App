//
//  SavedRecipeRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 14/10/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol SavedRecipeRoutingLogic {
    func routeToFoodDetail()
}

protocol SavedRecipeDataPassing {
    var dataStore: SavedRecipeDataStore? { get }
}

class SavedRecipeRouter: NSObject, SavedRecipeRoutingLogic, SavedRecipeDataPassing {
    weak var viewController: SavedRecipeViewController?
    var dataStore: SavedRecipeDataStore?
    
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
    
    func navigateToFoodDetail(source: SavedRecipeViewController, destination: FoodDetailViewController) {
        destination.modalPresentationStyle = .overFullScreen
        source.present(destination, animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToFoodDetailViewController(source: SavedRecipeDataStore, destination: inout FoodDetailDataStore) {
        destination.food = source.food
    }
}
