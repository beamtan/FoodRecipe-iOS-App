//
//  HomeViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    private var categories: [HomeModels.Category] = [
        HomeModels.Category(name: "Breakfast", isSelected: true),
        HomeModels.Category(name: "Lunch", isSelected: false),
        HomeModels.Category(name: "Dinner", isSelected: false),
        HomeModels.Category(name: "Snack", isSelected: false),
    ]
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularRecipeCollectionView: UICollectionView!
    
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
    }
    
    // MARK: - IBAction
    
    
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Display
    
    
    // MARK: - Navigation
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFeaturedCollectionView(collectionView) {
            return 2
        }
        
        if isCategoryCollectionView(collectionView) {
            return 4
        }
        
        if isPopularRecipeCollectionView(collectionView) {
            return 6
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isFeaturedCollectionView(collectionView) {
            return setUpFeaturedCell(collectionView, indexPath)
        }
        
        if isCategoryCollectionView(collectionView) {
            return setUpCategoryCell(collectionView, indexPath)
        }
        
        if isPopularRecipeCollectionView(collectionView) {
            return setUpPopularRecipeCell(collectionView, indexPath)
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - Set Up CollectionView

extension HomeViewController {
    private func isFeaturedCollectionView(_ collectionView: UICollectionView) -> Bool {
        return collectionView == featuredCollectionView
    }
    
    private func isCategoryCollectionView(_ collectionView: UICollectionView) -> Bool {
        return collectionView == categoryCollectionView
    }
    
    private func isPopularRecipeCollectionView(_ collectionView: UICollectionView) -> Bool {
        return collectionView == popularRecipeCollectionView
    }
    
    private func setUpFeaturedCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = featuredCollectionView.dequeueReusableCell(
            withReuseIdentifier: FeaturedCardCollectionViewCell.identifier,
            for: indexPath
        ) as! FeaturedCardCollectionViewCell
        
        let image: UIImage = (indexPath.row == 0) ?
        UIImage(named: "FeaturedCard1")! : UIImage(named: "FeaturedCard2")!
        
        cell.setUp(image: image)
        
        return cell
    }
    
    private func setUpCategoryCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath
        ) as! CategoryCollectionViewCell
        
        let category = categories[indexPath.row]
        let name: String = category.name
        let isSelected: Bool = category.isSelected
        
        cell.setUp(name: name, isSelectedCategory: isSelected)
        
        cell.categoryClosure = { [weak self] name in
            guard let self else { return }
            
            categories.enumerated().forEach { (index, category) in
                self.categories[index].isSelected = (category.name == name) ? true : false
            }
            
            categoryCollectionView.reloadData()
        }
        
        return cell
    }
    
    private func setUpPopularRecipeCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = popularRecipeCollectionView.dequeueReusableCell(
            withReuseIdentifier: PopularRecipeCollectionViewCell.identifier,
            for: indexPath
        ) as! PopularRecipeCollectionViewCell
        
        cell.foodClosure = { [weak self] in
            guard let self else { return }
            
            router?.routeToFoodDetail()
        }
        
        return cell
    }
}
