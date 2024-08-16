//
//  FoodDetailViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import Kingfisher

protocol FoodDetailDisplayLogic: AnyObject {
    func displayInquiryFoodDetailSuccess(viewModel: FoodDetailModels.InquiryFoodDetail.ViewModel)
    func displayInquiryFoodDetailFailure(viewModel: FoodDetailModels.InquiryFoodDetail.ViewModel)
    
    func displayInquiryFoodNutritionSuccess(viewModel: FoodDetailModels.InquiryFoodNutrition.ViewModel)
    func displayInquiryFoodNutritionFailure(viewModel: FoodDetailModels.InquiryFoodNutrition.ViewModel)
}

class FoodDetailViewController: UIViewController, FoodDetailDisplayLogic {
    
    enum Sections: Int, CaseIterable {
        case detail = 0
        case ingredients = 1
    }
    
    // MARK: - Properties
    
    var interactor: FoodDetailBusinessLogic?
    var router: (NSObjectProtocol & FoodDetailRoutingLogic & FoodDetailDataPassing)?
    
    private var food: FoodDetailModels.FoodDetailResponse? = nil
    private var nutrition: FoodDetailModels.FoodNutritionResponse? = nil
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var titleSolidBGHeaderLabel: UILabel!
    @IBOutlet weak private var foodImageView: UIImageView!
    
    @IBOutlet weak var foodImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var foodImageViewTopPadding: NSLayoutConstraint!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var closeButtonClearBG: UIButton!
    @IBOutlet weak var closeButtonSolidBG: UIButton!
    
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
        
        inquiryFoodDetail()
    }
    
    // MARK: - IBAction
    
//    @IBAction func ingredientsButtonPressed(_ sender: UIButton) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self else { return }
//            
//            UIView.animate(withDuration: 0.1) { [weak self] in
//                guard let self else { return }
//                
//                instructionsButton.backgroundColor = .E_6_EBF_2
//                instructionsButton.titleLabel?.textColor = .black
//                
//                sender.backgroundColor = ._042628
//                sender.titleLabel?.textColor = .white
//            }
//        }
//    }
//    
//    @IBAction func instructionsButtonPressed(_ sender: UIButton) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self else { return }
//            
//            UIView.animate(withDuration: 0.1) { [weak self] in
//                guard let self else { return }
//                
//                ingredientsButton.backgroundColor = .E_6_EBF_2
//                ingredientsButton.titleLabel?.textColor = .black
//                
//                sender.titleLabel?.textColor = .red
//                sender.backgroundColor = ._042628
//            }
//        }
//    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = FoodDetailInteractor()
        let presenter = FoodDetailPresenter()
        let router = FoodDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func updateFoodDetailUi() {
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.setImage(with: URL(string: food?.image ?? ""), placeholder: UIImage(named: "imagePlaceholder"))
        
        titleSolidBGHeaderLabel.text = food?.title
    }
    
    // MARK: - Call Service
    
    private func inquiryFoodDetail() {
        interactor?.inquiryFoodDetail()
    }
    
    private func inquiryFoodNutrition() {
        interactor?.inquiryFoodNutrition()
    }
    
    // MARK: - Display
    
    func displayInquiryFoodDetailSuccess(viewModel: FoodDetailModels.InquiryFoodDetail.ViewModel) {
        food = viewModel.data
        
        updateFoodDetailUi()
        collectionView.reloadData()
    }
    
    func displayInquiryFoodDetailFailure(viewModel: FoodDetailModels.InquiryFoodDetail.ViewModel) {
        
    }
    
    func displayInquiryFoodNutritionSuccess(viewModel: FoodDetailModels.InquiryFoodNutrition.ViewModel) {
        nutrition = viewModel.data
    }
    
    func displayInquiryFoodNutritionFailure(viewModel: FoodDetailModels.InquiryFoodNutrition.ViewModel) {
        
    }
    
    // MARK: - Navigation
    

}

extension FoodDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Sections.detail.rawValue {
            return 1
        }
        
        if section == Sections.ingredients.rawValue {
            return food?.extendedIngredients?.count ?? 0
        }
        
        return 0
    }
    
    /// Set up cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Sections.detail.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodDetailSheetCollectionViewCell", for: indexPath) as! FoodDetailSheetCollectionViewCell
            
            if let food {
                cell.setup(food: food)
            }
            
            return cell
        }
        
        if indexPath.section == Sections.ingredients.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientCollectionViewCell", for: indexPath) as! IngredientCollectionViewCell
            
            if let food, let extendedIngredients = food.extendedIngredients {
                cell.setup(ingredient: extendedIngredients[indexPath.row])
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - Implementation View

extension FoodDetailViewController {
    private func setupCollectionView() {
        /// Ingredient
        collectionView.register(
            UINib(nibName: "IngredientCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "IngredientCollectionViewCell"
        )
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            switch Sections(rawValue: sectionIndex) {
            case .detail:
                return self.createNSCollectionLayoutSectionDetail()
            case .ingredients:
                return self.createNSCollectionLayoutSectionIngredients()
            case .none:
                return nil
            }
        }
        
        return layout
    }
}
