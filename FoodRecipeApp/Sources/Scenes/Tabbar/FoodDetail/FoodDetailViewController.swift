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
        case totalAndType = 1
        case ingredients = 2
    }
    
    // MARK: - Properties
    
    var interactor: FoodDetailBusinessLogic?
    var router: (NSObjectProtocol & FoodDetailRoutingLogic & FoodDetailDataPassing)?
    
    private var food: FoodDetailModels.FoodDetailResponse? = nil
    private var nutrition: FoodDetailModels.FoodNutritionResponse? = nil
    
    private var foodDetailType: FoodDetailModels.FoodDetailType = .ingredient
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var titleSolidBGHeaderLabel: UILabel!
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var foodImageViewTopPadding: NSLayoutConstraint!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var closeButtonClearBG: UIButton!
    @IBOutlet weak var closeButtonSolidBG: UIButton!
    @IBOutlet weak var likeButtonSolidBG: UIButton!
    
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
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func heartPressed(_ sender: UIButton) {
        isFavoriteFood() ? unlikeFood() : likeFood()
        
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
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
    
    private func updateFoodDetailUi() {
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.setImage(with: URL(string: food?.image ?? ""), placeholder: UIImage(named: "imagePlaceholder"))
        
        titleSolidBGHeaderLabel.text = food?.title
        
        if let heartIcon = UIImage(systemName: "heart"),
           let fullHeartIcon = UIImage(systemName: "heart.fill")
        {
            let image = isFavoriteFood() ? fullHeartIcon : heartIcon
            let color: UIColor = isFavoriteFood() ? .red : .black
            
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            likeButtonSolidBG.setImage(tintedImage, for: .normal)
            likeButtonSolidBG.tintColor = color
            likeButtonSolidBG.backgroundColor = .white
        }
    }
    
    private func isFavoriteFood() -> Bool {
        let favFood = UserDefaultService.shared.getFavouriteFoods() ?? []
        if !favFood.contains(where: { $0.id == food?.id }) {
            return false
        }
        
        return true
    }
    
    private func unlikeFood() {
        guard let food else { return }
        
        UserDefaultService.shared.removeFavouriteFood(food: food) { [weak self] in
            guard let self else { return }
            
            if let image = UIImage(systemName: "heart") {
                
                likeButtonSolidBG.setImage(image, for: .normal)
                likeButtonSolidBG.tintColor = .black
                likeButtonSolidBG.backgroundColor = .E_6_EBF_2
            }
        }
    }
    
    private func likeFood() {
        guard let food else { return }
        
        UserDefaultService.shared.saveFavouriteFood(food: food) { [weak self] in
            guard let self else { return }
            
            if let image =  UIImage(systemName: "heart.fill") {
                
                likeButtonSolidBG.setImage(image, for: .normal)
                likeButtonSolidBG.tintColor = .red
                likeButtonSolidBG.backgroundColor = .E_3_C_3_C_6
            }
        }
    }
    
    // MARK: - Call Service
    
    private func inquiryFoodDetail() {
        interactor?.inquiryFoodDetail()
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
        
        if section == Sections.totalAndType.rawValue {
            return 1
        }
        
        if section == Sections.ingredients.rawValue && foodDetailType == .ingredient {
            return food?.extendedIngredients?.count ?? 0
        }
        
        if section == Sections.ingredients.rawValue && foodDetailType == .instruction {
            return food?.analyzedInstructions?.first?.steps?.count ?? 0
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
            
            cell.ingredientClosure = { [weak self] in
                guard let self else { return }
                
                foodDetailType = .ingredient
                collectionView.reloadSections([Sections.ingredients.rawValue, Sections.totalAndType.rawValue])
            }
            
            cell.instructionClosure = { [weak self] in
                guard let self else { return }
                
                foodDetailType = .instruction
                collectionView.reloadSections([Sections.ingredients.rawValue, Sections.totalAndType.rawValue])
            }
            
            return cell
        }
        
        if indexPath.section == Sections.totalAndType.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodDetailTypeAndTotalCollectionViewCell", for: indexPath) as! FoodDetailTypeAndTotalCollectionViewCell
            
            if let food {
                let totalExtendedIngredient: Int = food.extendedIngredients?.count ?? 0
                let totalStep: Int = food.analyzedInstructions?.first?.steps?.count ?? 0
                
                let total: Int = (foodDetailType == .ingredient) ? totalExtendedIngredient : totalStep
                cell.setup(type: foodDetailType, total: total)
            }
            
            return cell
        }
        
        if indexPath.section == Sections.ingredients.rawValue && foodDetailType == .ingredient {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientCollectionViewCell", for: indexPath) as! IngredientCollectionViewCell
            
            if let food, let extendedIngredients = food.extendedIngredients {
                cell.setup(ingredient: extendedIngredients[indexPath.row])
            }
            
            return cell
        }
        
        if indexPath.section == Sections.ingredients.rawValue && foodDetailType == .instruction {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstructionCollectionViewCell", for: indexPath) as! InstructionCollectionViewCell
            
            if let food, let step = food.analyzedInstructions?.first?.steps {
                cell.setup(instruction: step[indexPath.row])
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - Implementation View

extension FoodDetailViewController {
    private func setupCollectionView() {
        // Type and total
        collectionView.register(
            UINib(nibName: "FoodDetailTypeAndTotalCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "FoodDetailTypeAndTotalCollectionViewCell"
        )
        /// Ingredient
        collectionView.register(
            UINib(nibName: "IngredientCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "IngredientCollectionViewCell"
        )
        /// Instruction
        collectionView.register(
            UINib(nibName: "InstructionCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "InstructionCollectionViewCell"
        )
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            switch Sections(rawValue: sectionIndex) {
            case .detail:
                return self.createNSCollectionLayoutSectionDetail()
            case .totalAndType:
                return self.createNSCollectionLayoutSectionTypeAndTotal()
            case .ingredients:
                if foodDetailType == .ingredient {
                    return self.createNSCollectionLayoutSectionIngredients()
                }
                
                if foodDetailType == .instruction {
                    return self.createNSCollectionLayoutSectionInstructions()
                }
                
                return nil
            case .none:
                return nil
            }
        }
        
        return layout
    }
}
