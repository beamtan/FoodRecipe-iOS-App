//
//  SeeAllFoodViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 21/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SeeAllFoodDisplayLogic: AnyObject {
    func displaySomething(viewModel: SeeAllFoodModels.Something.ViewModel)
}

class SeeAllFoodViewController: UIViewController, SeeAllFoodDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: SeeAllFoodBusinessLogic?
    var router: (NSObjectProtocol & SeeAllFoodRoutingLogic & SeeAllFoodDataPassing)?
    
    // MARK: - IBOutlet
    
    
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: - IBAction
    
    
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = SeeAllFoodInteractor()
        let presenter = SeeAllFoodPresenter()
        let router = SeeAllFoodRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func doSomething() {
        let request = SeeAllFoodModels.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    // MARK: - Display
    
    func displaySomething(viewModel: SeeAllFoodModels.Something.ViewModel) {
        
    }
}
