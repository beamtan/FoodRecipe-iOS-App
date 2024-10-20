//
//  SeeAllFoodViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 21/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SeeAllFoodDisplayLogic: AnyObject {
    func displayInquirySearchFoodsByCategorySuccess(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel)
    func displayInquirySearchFoodsByCategoryFailure(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel)
    func displayGetCategoryValue(viewModel: SeeAllFoodModels.Category.ViewModel)
    
    func displayPrepareRouteToFoodDetailSuccess()
}

class SeeAllFoodViewController: UIViewController, SeeAllFoodDisplayLogic {
    
    // MARK: - Properties
    
    enum Layout {
        case grid
        case table
    }
    
    var interactor: SeeAllFoodBusinessLogic?
    var router: (NSObjectProtocol & SeeAllFoodRoutingLogic & SeeAllFoodDataPassing)?
    
    private var foods: [FoodDetailModels.FoodDetailResponse] = []
    private var category: HomeModels.Category.CategoryType = .mainCourse
    private var currentLayout: Layout = .grid
    
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
        
        getCategoryValue()
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
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            
            switch currentLayout {
            case .grid:
                return createNSCollectionLayoutSectionAllFoodGrid()
            case .table:
                return createNSCollectionLayoutSectionAllFoodTable()
            }
        }
    }
    
    private func setupCollectionView() {
        /// All Food
        collectionView.register(
            UINib(nibName: "SeeAllFoodHeaderCollectionViewCell", bundle: .main),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SeeAllFoodHeaderCollectionViewCell"
        )
        
        collectionView.register(
            UINib(nibName: "SearchResultTableCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "SearchResultTableCollectionViewCell"
        )
    }
    
    private func getCategoryValue() {
        let request = SeeAllFoodModels.Category.Request()
        interactor?.getCategoryValue(request: request)
    }
    
    // MARK: - Call Service
    
    func inquirySearchFoodByCategory(selectedCategory: HomeModels.Category.CategoryType) {
        let totalFoodRequest: Int = 30
        
        let request = HomeModels.InquirySearchFoodsByQueryText.Request(
            query: selectedCategory.rawValue,
            number: totalFoodRequest,
            isAddRecipeNutrition: true,
            isAddRecipeInstructions: true,
            isFillIngredients: true,
            sort: "random"
        )
        interactor?.inquirySearchFoodsByCategory(request: request)
    }
    
    // MARK: - Display
    
    func displayInquirySearchFoodsByCategorySuccess(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel) {
        foods = viewModel.data?.results ?? []
        collectionView.reloadData()
    }
    
    func displayInquirySearchFoodsByCategoryFailure(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel) {
        
    }
    
    func displayGetCategoryValue(viewModel: SeeAllFoodModels.Category.ViewModel) {
        category = viewModel.category
        inquirySearchFoodByCategory(selectedCategory: viewModel.category)
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

extension SeeAllFoodViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if currentLayout == .grid {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeeAllFoodCollectionViewCell", for: indexPath) as! SeeAllFoodCollectionViewCell
            
            if let food = foods[safe: indexPath.row] {
                cell.setup(food: food)
                
                cell.cardPressClosure = { [weak self] in
                    guard let self else { return }
                    
                    prepareRouteToFoodDetail(food: food)
                }
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultTableCollectionViewCell", for: indexPath) as! SearchResultTableCollectionViewCell
            
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
    }
    
    // MARK: - Set up header
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "SeeAllFoodHeaderCollectionViewCell",
                for: indexPath
            ) as! SeeAllFoodHeaderCollectionViewCell
            
            header.setup(category: category)
            
            header.gridButtonClosured = { [weak self] in
                guard let self, currentLayout == .table else { return }
                
                currentLayout = .grid
                collectionView.reloadData()
            }
            
            header.tableButtonClosured = { [weak self] in
                guard let self, currentLayout == .grid else { return }
                
                currentLayout = .table
                collectionView.reloadData()
            }
            
            header.backClosure = { [weak self] in
                guard let self else { return }
                
                navigationController?.popViewController(animated: true)
            }
            
            return header
        }
        
        return UICollectionReusableView()
    }
}
