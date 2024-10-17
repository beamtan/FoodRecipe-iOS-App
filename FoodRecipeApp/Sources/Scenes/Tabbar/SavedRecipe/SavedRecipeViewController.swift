//
//  SavedRecipeViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 14/10/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SavedRecipeDisplayLogic: AnyObject {
    func displayInquiryFavoriteFoods(viewModel: SavedRecipeModels.InquiryFavoriteFoods.ViewModel)
    
    // Route
    func displayPrepareRouteToFoodDetailSuccess()
}

class SavedRecipeViewController: UIViewController, SavedRecipeDisplayLogic {
    
    // MARK: - Properties
    
    enum Sections: Int, CaseIterable {
        case title = 0
        case favorites = 1
    }
    
    enum Layout {
        case grid
        case table
    }
    
    var interactor: SavedRecipeBusinessLogic?
    var router: (NSObjectProtocol & SavedRecipeRoutingLogic & SavedRecipeDataPassing)?
    
    private var favoriteFoods: [FoodDetailModels.FoodDetailResponse]?
    private var currentLayout: Layout = .grid
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    
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
        
        setupCollectionView()
        collectionView.collectionViewLayout = createLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inquiryFavoriteFoods()
    }
    
    // MARK: - IBAction
    
    
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = SavedRecipeInteractor()
        let presenter = SavedRecipePresenter()
        let router = SavedRecipeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupCollectionView() {
        /// Title
        collectionView.register(
            UINib(nibName: "SavedRecipeTitleCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "SavedRecipeTitleCollectionViewCell"
        )
        
        /// My Favorites List
        collectionView.register(
            UINib(nibName: "ProfileFavHeaderCollectionViewCell", bundle: .main),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "ProfileFavHeaderCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "ProfileFavCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "ProfileFavCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "SavedRecipeTableCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "SavedRecipeTableCollectionViewCell"
        )
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            
            switch Sections(rawValue: sectionIndex) {
            case .title:
                return createNSCollectionLayoutSectionTitle()
            case .favorites:
                if currentLayout == .grid {
                    return createNSCollectionLayoutSectionFavorites()
                } else {
                    return createNSCollectionLayoutSectionFavoritesTable()
                }
            case .none:
                return nil
            }
        }
    }
    
    // MARK: - Get Data
    
    func inquiryFavoriteFoods() {
        let request = SavedRecipeModels.InquiryFavoriteFoods.Request()
        interactor?.inquiryFavoriteFoods(request: request)
    }
    
    // MARK: - Display
    
    func displayInquiryFavoriteFoods(viewModel: SavedRecipeModels.InquiryFavoriteFoods.ViewModel) {
        favoriteFoods = viewModel.data
        collectionView.reloadSections([Sections.favorites.rawValue])
    }
    
    func displayPrepareRouteToFoodDetailSuccess() {
        router?.routeToFoodDetail()
    }
    
    // MARK: - Navigation
    
    func prepareRouteToFoodDetail(food: FoodDetailModels.FoodDetailResponse) {
        interactor?.prepareRouteToFoodDetail(food: food)
    }
}

// MARK: - UICollectionViewDelegate

extension SavedRecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Sections.title.rawValue {
            return 1
        }
        
        if section == Sections.favorites.rawValue {
            return favoriteFoods?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Sections.title.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedRecipeTitleCollectionViewCell", for: indexPath) as! SavedRecipeTitleCollectionViewCell
            
            cell.gridButtonClosured = { [weak self] in
                guard let self, currentLayout == .table else { return }
                
                currentLayout = .grid
                collectionView.reloadSections([Sections.favorites.rawValue])
            }
            
            cell.tableButtonClosured = { [weak self] in
                guard let self, currentLayout == .grid else { return }
                
                currentLayout = .table
                collectionView.reloadSections([Sections.favorites.rawValue])
            }
            
            return cell
        }
        
        if indexPath.section == Sections.favorites.rawValue {
            if currentLayout == .grid {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileFavCollectionViewCell", for: indexPath) as! ProfileFavCollectionViewCell
                
                if let favFood = favoriteFoods?[indexPath.row] {
                    cell.setup(favFood: favFood)
                }
                
                cell.foodClosure = { [weak self] in
                    guard let self else { return }
                    
                    
                    if let food = favoriteFoods?[safe: indexPath.row] {
                        prepareRouteToFoodDetail(food: food)
                    }
                }
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedRecipeTableCollectionViewCell", for: indexPath) as! SavedRecipeTableCollectionViewCell
                
                if let food = favoriteFoods?[safe: indexPath.row] {
                    cell.setup(food: food)
                }
                
                cell.foodClosure = { [weak self] in
                    guard let self else { return }
                    
                    
                    if let food = favoriteFoods?[safe: indexPath.row] {
                        prepareRouteToFoodDetail(food: food)
                    }
                }
                
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    /// Set up header
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader &&
            indexPath.section == Sections.favorites.rawValue {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "ProfileFavHeaderCollectionViewCell",
                for: indexPath
            ) as! ProfileFavHeaderCollectionViewCell
            
            return header
        }
        
        return UICollectionReusableView()
    }
}
