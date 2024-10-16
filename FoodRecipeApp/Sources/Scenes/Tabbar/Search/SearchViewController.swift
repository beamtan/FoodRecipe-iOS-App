//
//  SearchViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    func displaySearchFoodsByQuerySuccess(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel)
    func displaySearchFoodsByQueryFailure(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel)
    
    // Route
    func displayPrepareRouteToFoodDetailSuccess()
}

class SearchViewController: UIViewController, SearchDisplayLogic {

    // MARK: - Properties
    
    enum Sections: Int, CaseIterable {
        case searchTitle = 0
        case searchResult = 1
    }
    
    enum Layout {
        case grid
        case table
    }
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    private var categories: HomeModels.Category = HomeModels.Category()
    private var foods: [FoodDetailModels.FoodDetailResponse] = []
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
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            
            switch Sections(rawValue: sectionIndex) {
            case .searchTitle:
                return createNSCollectionLayoutSectionSearchTitle()
            case .searchResult:
                if currentLayout == .grid {
                    return createNSCollectionLayoutSectionSearchResultGrid()
                } else {
                    return createNSCollectionLayoutSectionSearchResultTable()
                }
                
            case .none:
                return nil
            }
        }
    }
    
    private func setupCollectionView() {
        /// Search Title
        collectionView.register(
            UINib(nibName: "SearchTitleCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "SearchTitleCollectionViewCell"
        )
        
        /// SearchTextField Header
        collectionView.register(
            UINib(nibName: "SearchTextFieldCollectionReusableView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SearchTextFieldCollectionReusableView"
        )
        
        /// Search Result
        collectionView.register(
            UINib(nibName: "SearchResultGridCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "SearchResultGridCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "SearchResultTableCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "SearchResultTableCollectionViewCell"
        )
    }
    
    // MARK: - Call Service
    
    private func inquirySearchFood(_ text: String) {
        startLoadingLottie()
        
        let request = HomeModels.InquirySearchFoodsByQueryText.Request(
            query: text,
            number: 10,
            isAddRecipeNutrition: true,
            isAddRecipeInstructions: true,
            isFillIngredients: true
        )
        
        interactor?.inquirySearchFoodsByQuery(request: request)
    }
    
    // MARK: - Display
    
    func displaySearchFoodsByQuerySuccess(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel) {
        foods = viewModel.data?.results ?? []
        collectionView.reloadSections([Sections.searchResult.rawValue])
        
        stopLoadingLottie()
    }
    
    func displaySearchFoodsByQueryFailure(viewModel: HomeModels.InquirySearchFoodsByQueryText.ViewModel) {
        stopLoadingLottie()
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

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Sections.searchTitle.rawValue {
            return 1
        }
        
        if section == Sections.searchResult.rawValue {
            return foods.count
        }
        
        return 0
    }
    
    /// Set up cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Sections.searchTitle.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchTitleCollectionViewCell", for: indexPath) as! SearchTitleCollectionViewCell
            
            cell.gridButtonClosured = { [weak self] in
                guard let self else { return }
                
                currentLayout = .grid
                collectionView.reloadSections([Sections.searchResult.rawValue])
            }
            
            cell.tableButtonClosured = { [weak self] in
                guard let self else { return }
                
                currentLayout = .table
                collectionView.reloadSections([Sections.searchResult.rawValue])
            }
            
            return cell
        }
        
        if indexPath.section == Sections.searchResult.rawValue {
            if currentLayout == .grid {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultGridCollectionViewCell", for: indexPath) as! SearchResultGridCollectionViewCell
                
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
            
            if currentLayout == .table {
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
        
        return UICollectionViewCell()
    }
    
    // MARK: - Set up header
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader &&
            indexPath.section == Sections.searchResult.rawValue {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "SearchTextFieldCollectionReusableView",
                for: indexPath
            ) as! SearchTextFieldCollectionReusableView
            
            header.textFieldShouldReturnClosure = { [weak self] text in
                guard let self, !text.isEmpty else {
                    return
                }
                
                inquirySearchFood(text)
            }
            
            return header
        }
        
        return UICollectionReusableView()
    }
}
