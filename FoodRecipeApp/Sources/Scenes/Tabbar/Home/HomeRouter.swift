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
    func routeToAllRecipe()
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
    
    func routeToAllRecipe() {
        guard let destination = UIStoryboard(name: "SeeAllFoodStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SeeAllFoodViewController") as? SeeAllFoodViewController else { return }
        
        guard let viewController,
              let dataStore,
              var destinationDataStore = destination.router?.dataStore else {
            return
        }
        
        passDataToSeeAllFoodViewController(source: dataStore, destination: &destinationDataStore)
        navigateToSeeAllFood(source: viewController, destination: destination)
    }
    
    // MARK: Navigation
    
    func navigateToFoodDetail(source: HomeViewController, destination: FoodDetailViewController) {
        destination.modalPresentationStyle = .overFullScreen
        source.present(destination, animated: true)
    }
    
    func navigateToSeeAllFood(source: HomeViewController, destination: SeeAllFoodViewController) {
        if let navigationController = source.navigationController {
            navigationController.pushViewController(destination, animated: true)
        } else {
            print("NavigationController is nil")
        }
    }
    
    // MARK: Passing data
    
    func passDataToFoodDetailViewController(source: HomeDataStore, destination: inout FoodDetailDataStore) {
        destination.food = source.food
    }
    
    func passDataToSeeAllFoodViewController(source: HomeDataStore, destination: inout SeeAllFoodDataStore) {
//        destination.food = source.food
    }
}
