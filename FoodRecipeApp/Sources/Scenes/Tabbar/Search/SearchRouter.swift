//
//  SearchRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol SearchRoutingLogic {
    func routeToFoodDetail()
}

protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?
    
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
    
    func navigateToFoodDetail(source: SearchViewController, destination: FoodDetailViewController) {
        destination.modalPresentationStyle = .overFullScreen
        source.present(destination, animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToFoodDetailViewController(source: SearchDataStore, destination: inout FoodDetailDataStore) {
        destination.food = source.food
    }
}
