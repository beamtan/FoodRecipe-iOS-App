//
//  HomeViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayInquirySearchFoodsByCategorySuccess(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel)
    func displayInquirySearchFoodsByCategoryFailure(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel)
    
    /// Route
    func displayPrepareRouteToFoodDetailSuccess()
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    enum Sections: Int, CaseIterable {
        case name = 0
        case featured = 1
        case category = 2
        case popularRecipe = 3
    }
    
    // MARK: - Properties
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    private var categories: HomeModels.Category = HomeModels.Category()
    private var foods: [FoodDetailModels.FoodDetailResponse] = []
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        
        inquirySearchFoodByCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadSections([Sections.popularRecipe.rawValue])
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
    
    // MARK: - Call Service
    
    func inquirySearchFoodByCategory() {
        let selectedCategory: String = categories.categories.first(
            where: { $0.isSelected }
        )?.category.rawValue ?? ""
        let totalFoodRequest: Int = 4
        
        let request = HomeModels.InquirySearchFoodsByQueryText.Request(
            query: selectedCategory,
            number: totalFoodRequest,
            isAddRecipeNutrition: true,
            isAddRecipeInstructions: true,
            isFillIngredients: true,
            sort: "popularity",
            sortDirection: "desc"
        )
        interactor?.inquirySearchFoodsByCategory(request: request)
    }
    
    // MARK: - Display
    
    func displayInquirySearchFoodsByCategorySuccess(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel) {
        foods = viewModel.data?.results ?? []
        collectionView.reloadSections([Sections.popularRecipe.rawValue])
    }
    
    func displayInquirySearchFoodsByCategoryFailure(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel) {
        
    }
    
    func displayPrepareRouteToFoodDetailSuccess() {
        router?.routeToFoodDetail()
    }
    
    // MARK: - Navigation
    
    func prepareRouteToFoodDetail(food: FoodDetailModels.FoodDetailResponse) {
        interactor?.prepareRouteToFoodDetail(food: food)
    }
}

// MARK: - Implementation View

extension HomeViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            
            switch Sections(rawValue: sectionIndex) {
            case .name:
                return createNSCollectionLayoutSectionName()
            case .featured:
                return createNSCollectionLayoutSectionFeatured()
            case .category:
                return createNSCollectionLayoutSectionCategory()
            case .popularRecipe:
                return createNSCollectionLayoutSectionPopularRecipe()
            case .none:
                return nil
            }
        }
    }
    
    private func setupCollectionView() {
        /// Name
        collectionView.register(
            UINib(nibName: "NameHeaderViewCell", bundle: .main),
            forCellWithReuseIdentifier: "NameHeaderViewCell"
        )
        
        /// Featured
        collectionView.register(
            UINib(nibName: "FeaturedHeaderCollectionViewCell", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "FeaturedHeaderCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "FeaturedCardCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "FeaturedCardCollectionViewCell"
        )
        
        /// Category
        collectionView.register(
            UINib(nibName: "CategoryHeaderCollectionViewCell", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "CategoryHeaderCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "CategoryCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "CategoryCollectionViewCell"
        )
        
        /// Popular Recipe
        collectionView.register(
            UINib(nibName: "PopularRecipeHeaderCollectionViewCell", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "PopularRecipeHeaderCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "PopularRecipeCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "PopularRecipeCollectionViewCell"
        )
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Sections.name.rawValue {
            return 1
        }
        
        if section == Sections.featured.rawValue {
            return 2
        }
        
        if section == Sections.category.rawValue {
            return categories.categories.count
        }
        
        if section == Sections.popularRecipe.rawValue {
            return foods.count
        }
        
        return 0
    }
    
    // MARK: - Set up cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Sections.name.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameHeaderViewCell", for: indexPath) as! NameHeaderViewCell
            return cell
        }
        
        if indexPath.section == Sections.featured.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCardCollectionViewCell", for: indexPath) as! FeaturedCardCollectionViewCell
            return cell
        }
        
        if indexPath.section == Sections.category.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            
            let indexCategory = categories.categories[indexPath.row]
            let categoryName: String = indexCategory.category.rawValue
            let isCategorySelected: Bool = indexCategory.isSelected
            
            cell.setUp(
                name: categoryName,
                isSelectedCategory: isCategorySelected
            )
            
            cell.categoryClosure = { [weak self] name in
                guard let self else { return }
                
                categories.categories.enumerated().forEach { (index, category) in
                    self.categories.categories[index].isSelected = (category.category.rawValue == name) ? true : false
                    
                    let indexPath = IndexPath(item: index, section: Sections.category.rawValue)
                    collectionView.reloadItems(at: [indexPath])
                }
                
                if let selectedIndex = self.categories.categories.firstIndex(
                    where: { $0.category.rawValue == name }
                ) {
                    let indexPath = IndexPath(item: selectedIndex, section: Sections.category.rawValue)
                    
                    collectionView.scrollToItem(
                        at: indexPath,
                        at: .centeredHorizontally,
                        animated: true
                    )
                }
                
                inquirySearchFoodByCategory()
            }
            
            return cell
        }
        
        if indexPath.section == Sections.popularRecipe.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularRecipeCollectionViewCell", for: indexPath) as! PopularRecipeCollectionViewCell
            
            if let food = foods[safe: indexPath.row] {
                cell.setup(food: food)
            }
            
            cell.foodClosure = { [weak self] in
                guard let self else { return }
                    
                
                if let food = foods[safe: indexPath.row] {
                    prepareRouteToFoodDetail(food: food)
                }
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: - Set up header
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader &&
            indexPath.section == Sections.featured.rawValue {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "FeaturedHeaderCollectionViewCell",
                for: indexPath
            ) as! FeaturedHeaderCollectionViewCell
            
            return header
        }
        
        if kind == UICollectionView.elementKindSectionHeader &&
            indexPath.section == Sections.category.rawValue {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "CategoryHeaderCollectionViewCell",
                for: indexPath
            ) as! CategoryHeaderCollectionViewCell
            
            return header
        }
        
        if kind == UICollectionView.elementKindSectionHeader &&
            indexPath.section == Sections.popularRecipe.rawValue {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "PopularRecipeHeaderCollectionViewCell",
                for: indexPath
            ) as! PopularRecipeHeaderCollectionViewCell
            
            header.seeAllClosure = { [weak self] in
                guard let self else { return }
                
                router?.routeToAllRecipe()
            }
            
            return header
        }
        
        return UICollectionReusableView()
    }
}
