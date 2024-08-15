//
//  HomeViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayInquiryFoodCategoriesSuccess(viewModel: HomeModels.InquiryFoodCategories.ViewModel)
    func displayInquiryFoodCategoriesFailure(viewModel: HomeModels.InquiryFoodCategories.ViewModel)
    
    func displayInquirySearchFoodsByCategorySuccess(viewModel: HomeModels.InquirySearchFoodsByCategory.ViewModel)
    func displayInquirySearchFoodsByCategoryFailure(viewModel: HomeModels.InquirySearchFoodsByCategory.ViewModel)
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
    
//    var categories: [HomeModels.Category] = [
//        HomeModels.Category(name: "Breakfast", isSelected: true),
//        HomeModels.Category(name: "Lunch", isSelected: false),
//        HomeModels.Category(name: "Dinner", isSelected: false),
//        HomeModels.Category(name: "Snack", isSelected: false),
//    ]
    
    var categories: [HomeModels.WelcomeResponse.Category?] = []
    var foods: [HomeModels.MealsResponse.Meals?] = []
    
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
        
        inquiryFoodCategories()
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
    
    // MARK: - Call Service
    
    func inquiryFoodCategories() {
        let request = HomeModels.InquiryFoodCategories.Request()
        interactor?.inquiryFoodCategories(request: request)
    }
    
    func inquirySearchFoodByCategory() {
        let selectedCategory: String = categories.first(
            where: { $0?.isSelected ?? false }
        )??.strCategory ?? ""
        let request = HomeModels.InquirySearchFoodsByCategory.Request(category: selectedCategory)
        interactor?.inquirySearchFoodsByCategory(request: request)
    }
    
    // MARK: - Display
    
    func displayInquiryFoodCategoriesSuccess(viewModel: HomeModels.InquiryFoodCategories.ViewModel) {
        categories = viewModel.data?.categories ?? []
        categories[0]?.isSelected = true
        
        collectionView.reloadSections([Sections.category.rawValue])
        
        inquirySearchFoodByCategory()
    }
    
    func displayInquiryFoodCategoriesFailure(viewModel: HomeModels.InquiryFoodCategories.ViewModel) {
        
    }
    
    func displayInquirySearchFoodsByCategorySuccess(viewModel: HomeModels.InquirySearchFoodsByCategory.ViewModel) {
        foods = viewModel.data?.meals ?? []
        collectionView.reloadSections([Sections.popularRecipe.rawValue])
    }
    
    func displayInquirySearchFoodsByCategoryFailure(viewModel: HomeModels.InquirySearchFoodsByCategory.ViewModel) {
        
    }
    
    // MARK: - Navigation
    
    
}

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
            return categories.count
        }
        
        if section == Sections.popularRecipe.rawValue {
            return foods.count
        }
        
        return 0
    }
    
    /// Set up cell
    
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
            
            cell.setUp(
                name: categories[indexPath.row]?.strCategory ?? "",
                isSelectedCategory: categories[indexPath.row]?.isSelected ?? false
            )
            
            let category = categories[indexPath.row]
            let name: String = category?.strCategory ?? ""
            let isSelected: Bool = category?.isSelected ?? false
            
            cell.setUp(name: name, isSelectedCategory: isSelected)
            
            cell.categoryClosure = { [weak self] name in
                guard let self else { return }
                
                categories.enumerated().forEach { (index, category) in
                    self.categories[index]?.isSelected = (category?.strCategory == name) ? true : false
                }
                
                collectionView.reloadSections([Sections.category.rawValue])
            }
            
            return cell
        }
        
        if indexPath.section == Sections.popularRecipe.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularRecipeCollectionViewCell", for: indexPath) as! PopularRecipeCollectionViewCell
            
            if foods.count > 0 {
                if let meal = foods[indexPath.row] {
                    cell.setup(meal: meal)
                }
            }
            
            cell.foodClosure = { [weak self] in
                guard let self else { return }
                    
                router?.routeToFoodDetail()
            }
            
            return cell
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
            
            return header
        }
        
        return UICollectionReusableView()
    }
}
