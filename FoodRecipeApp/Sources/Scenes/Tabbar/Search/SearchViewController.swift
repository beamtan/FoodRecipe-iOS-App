//
//  SearchViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    func displaySomething(viewModel: SearchModels.Something.ViewModel)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    private var categories: [HomeModels.Category] = [
        HomeModels.Category(name: "Breakfast", isSelected: true),
        HomeModels.Category(name: "Lunch", isSelected: false),
        HomeModels.Category(name: "Dinner", isSelected: false),
        HomeModels.Category(name: "Snack", isSelected: false),
    ]
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var categoryCollectionView: UICollectionView!
    @IBOutlet weak private var searchTextFieldView: UIView! {
        didSet {
            searchTextFieldView.layer.borderColor = UIColor.D_2_D_4_D_8.cgColor
            searchTextFieldView.layer.borderWidth = 1.0
        }
    }
    
    @IBOutlet weak private var popularRecipeViewAllButtonView: UILabel!
    @IBOutlet weak private var editorChoiceViewAllButtonView: UILabel!

    @IBOutlet weak private var searchPopularRecipeCollectionView: UICollectionView!
//    @IBOutlet weak private var editorChoiceCollectionView: UICollectionView!
    
    @IBOutlet weak var editorChoiceStackView: UIStackView!
    
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
        
        configEditorChoiceCard()
    }
    
    // MARK: - IBAction
    
    
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func doSomething() {
        let request = SearchModels.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func configEditorChoiceCard() {
        for i in 0...10 {
            let cardView = EditorChoiceCardView()
            
            cardView.configureView(
                imageView: UIImage(named: "burger") ?? UIImage(),
                userImageView: UIImage(named: "girlDev") ?? UIImage(),
                title: "Easy homemade beef burger \(i)",
                name: "Beamtan Dev",
                nextToClosure: {}
            )
            
            editorChoiceStackView.addArrangedSubview(view)
        }
    }
    
    // MARK: - Display
    
    func displaySomething(viewModel: SearchModels.Something.ViewModel) {
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isCategoryCollectionView(collectionView) {
            return 4
        }
        
        if isSearchPopularRecipeCollectionView(collectionView) {
            return 6
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isCategoryCollectionView(collectionView) {
            return setUpCategoryCell(collectionView, indexPath)
        }
        
        if isSearchPopularRecipeCollectionView(collectionView) {
            return setUpSearchPopularRecipeCollectionViewCell(collectionView, indexPath)
        }
        
        return UICollectionViewCell()
    }
}

extension SearchViewController {
    private func isCategoryCollectionView(_ collectionView: UICollectionView) -> Bool {
        return collectionView == categoryCollectionView
    }
    
    private func isSearchPopularRecipeCollectionView(_ collectionView: UICollectionView) -> Bool {
        return collectionView == searchPopularRecipeCollectionView
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
    
    private func setUpSearchPopularRecipeCollectionViewCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchPopularRecipeCollectionView.dequeueReusableCell(
            withReuseIdentifier: SearchPopularRecipeCollectionViewCell.identifier,
            for: indexPath
        ) as! SearchPopularRecipeCollectionViewCell
        
        return cell
    }
}
