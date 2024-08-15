//
//  FoodDetailViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol FoodDetailDisplayLogic: AnyObject {
    func displaySomething(viewModel: FoodDetailModels.Something.ViewModel)
}

class FoodDetailViewController: UIViewController, FoodDetailDisplayLogic {
    
    enum Sections: Int, CaseIterable {
        case detail = 0
        case ingredients = 1
    }
    
    // MARK: - Properties
    
    var interactor: FoodDetailBusinessLogic?
    var router: (NSObjectProtocol & FoodDetailRoutingLogic & FoodDetailDataPassing)?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var foodImageView: UIImageView!
    
    @IBOutlet weak private var foodImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var foodImageViewTopPadding: NSLayoutConstraint!
    
    @IBOutlet weak private var headerView: UIView!
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
        doSomething()
        
        setupCollectionView()
        collectionView.collectionViewLayout = createLayout()
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
    
    func doSomething() {
        let request = FoodDetailModels.Something.Request()
        interactor?.doSomething(request: request)
    }
    
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
    
    // MARK: - Display
    
    func displaySomething(viewModel: FoodDetailModels.Something.ViewModel) {
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
            return 8
        }
        
        return 0
    }
    
    /// Set up cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Sections.detail.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodDetailSheetCollectionViewCell", for: indexPath) as! FoodDetailSheetCollectionViewCell
            return cell
        }
        
        if indexPath.section == Sections.ingredients.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientCollectionViewCell", for: indexPath) as! IngredientCollectionViewCell
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - UIScrollViewDelegate

extension FoodDetailViewController: UIScrollViewDelegate {
    
    // Make the effect of disappear header and stretch image
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y // down = -, up = +
        
        let originSheetY: CGFloat = -59.0
        let intersectionPointOfSheetAndHeader: CGFloat = 93
        
        let isImageBeginStretch: Bool = offsetY < originSheetY
        let isHeaderShow: Bool = offsetY > intersectionPointOfSheetAndHeader
        let isHeaderViewAlreadyHidden: Bool = headerView.layer.opacity == 0
        
        // In which any way image will change by height or padding eventually
        
        if isImageBeginStretch {
            // Stretching mean image is only getting bigger so the different should be positive only
            
            let differentBetweenSheetAndImage: CGFloat = abs(offsetY) - abs(originSheetY)
            let imageOriginHeight: CGFloat = 280
            
            foodImageViewHeight.constant = imageOriginHeight + differentBetweenSheetAndImage
        } else {
            let differentBetweenSheetAndImage: CGFloat = offsetY - originSheetY
            let isUpDirection: Bool = differentBetweenSheetAndImage > 0
            
            if isUpDirection && !isHeaderShow {
                // Divide by 3 for slower rate compare to sheet
                // Make it negative for up direction
                
                foodImageViewTopPadding.constant = (differentBetweenSheetAndImage / 3) * -1
            }
        }
        
        if isHeaderShow {
            let differentSheetAndHeaderOverlap: CGFloat = abs(intersectionPointOfSheetAndHeader) - abs(offsetY)
            
            // To make opacity from the different point of y
            // Divide by 100 to make the different smoothly with ratio as 0 is min opacity and 1 is max opacity
            
            headerView.layer.opacity = Float(min(abs(differentSheetAndHeaderOverlap) / 100, 1))
            closeButtonSolidBG.layer.opacity = Float((1 - (abs(differentSheetAndHeaderOverlap) / 100)))
            
            return
        }
        
        if isHeaderViewAlreadyHidden {
            return
        }
        
        headerView.layer.opacity = 0
    }
}

extension FoodDetailViewController {
    // Detail
    private func createNSCollectionLayoutSectionDetail() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(407.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(407.0)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // vertical align use main scroll
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        return section
    }
    
    // Ingredients
    private func createNSCollectionLayoutSectionIngredients() -> NSCollectionLayoutSection {
        let padding: CGFloat = 32
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), // fractional 1.0 as one item per row
                heightDimension: .absolute(80 + padding) // vertical control the height by item instead
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(300) // vertical align need the group to extend as need
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // vertical align use main scroll
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        return section
    }
}
