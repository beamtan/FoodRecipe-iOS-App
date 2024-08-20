//
//  HomeRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    func routeToFoodDetail()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
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
    
    func navigateToFoodDetail(source: HomeViewController, destination: FoodDetailViewController) {
        destination.modalPresentationStyle = .overFullScreen
        source.present(destination, animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToFoodDetailViewController(source: HomeDataStore, destination: inout FoodDetailDataStore) {
        destination.food = source.food
    }
}
