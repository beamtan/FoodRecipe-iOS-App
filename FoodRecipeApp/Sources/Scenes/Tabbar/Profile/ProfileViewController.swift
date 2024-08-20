//
//  ProfileViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol ProfileDisplayLogic: AnyObject {
    func displayInquiryFavouriteFoods(viewModel: ProfileModels.InquiryFavouriteFoods.ViewModel)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {
    
    enum Sections: Int, CaseIterable {
        case accountTitle = 0
        case account = 1
        case favorites = 2
    }
    
    // MARK: - Properties
    
    var interactor: ProfileBusinessLogic?
    var router: (NSObjectProtocol & ProfileRoutingLogic & ProfileDataPassing)?
    
    private var favouriteFoods: [FoodDetailModels.FoodDetailResponse]?
    
    // MARK: - IBOutlet
    
    //    @IBOutlet weak private var profileCardView: UIView! {
    //        didSet {
    //            profileCardView.layer.shadowColor = UIColor.black.cgColor
    //            profileCardView.layer.shadowOpacity = 0.1
    //            profileCardView.layer.shadowOffset = CGSize(width: 0, height: 1)
    //            profileCardView.layer.shadowRadius = 2
    //        }
    //    }
    //    @IBOutlet weak private var profileImageView: UIImageView!
    //    @IBOutlet weak private var profileNameLabel: UILabel!
    //    @IBOutlet weak private var profileRole: UILabel!
    //
    //    @IBOutlet weak var profileFavCollectionView: UICollectionView!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inquiryFavouriteFoods()
    }
    
    // MARK: - IBAction
    
    
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
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
            case .accountTitle:
                return createNSCollectionLayoutSectionAccountTitle()
            case .account:
                return createNSCollectionLayoutSectionAccount()
            case .favorites:
                return createNSCollectionLayoutSectionFavorites()
            case .none:
                return nil
            }
        }
    }
    
    private func setupCollectionView() {
        /// Account Title
        collectionView.register(
            UINib(nibName: "AccountTitleCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "AccountTitleCollectionViewCell"
        )
        
        /// Account Card
        collectionView.register(
            UINib(nibName: "AccountCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "AccountCollectionViewCell"
        )
        
        /// My Favorites
        collectionView.register(
            UINib(nibName: "ProfileFavHeaderCollectionViewCell", bundle: .main),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "ProfileFavHeaderCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "ProfileFavCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "ProfileFavCollectionViewCell"
        )
    }
    
    // MARK: - Get Data
    
    func inquiryFavouriteFoods() {
        let request = ProfileModels.InquiryFavouriteFoods.Request()
        interactor?.inquiryFavouriteFoods(request: request)
    }
    
    // MARK: - Display
    
    func displayInquiryFavouriteFoods(viewModel: ProfileModels.InquiryFavouriteFoods.ViewModel) {
        favouriteFoods = viewModel.data
        collectionView.reloadSections([Sections.favorites.rawValue])
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Sections.accountTitle.rawValue {
            return 1
        }
        
        if section == Sections.account.rawValue {
            return 1
        }
        
        if section == Sections.favorites.rawValue {
            return favouriteFoods?.count ?? 0
        }
        
        return 0
    }
    
    /// Set up cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Sections.accountTitle.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountTitleCollectionViewCell", for: indexPath) as! AccountTitleCollectionViewCell
            return cell
        }
        
        if indexPath.section == Sections.account.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionViewCell", for: indexPath) as! AccountCollectionViewCell
            return cell
        }
        
        if indexPath.section == Sections.favorites.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileFavCollectionViewCell", for: indexPath) as! ProfileFavCollectionViewCell
            
            if let favFood = favouriteFoods?[indexPath.row] {
                cell.setup(favFood: favFood)
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

// MARK: - NSCollectionLayoutSection Helper

extension ProfileViewController {
    // AccountTitle
    private func createNSCollectionLayoutSectionAccountTitle() -> NSCollectionLayoutSection {
        /// item = cell
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        /// Group = cell container
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(64)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        return section
    }
    
    // Account
    private func createNSCollectionLayoutSectionAccount() -> NSCollectionLayoutSection {
        let sectionPadding: CGFloat = 24
        let shadowPadding: CGFloat = 8
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0) // vertical control the height by item instead
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
            
        )
        
        /// Group = cell container

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(96) // vertical align need the group to extend as need
            ),
            subitems: [item]
        )
        
        // Section = Section container: header, footer can be shown
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // vertical align use main scroll
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: sectionPadding - shadowPadding,
            bottom: 0,
            trailing: sectionPadding - shadowPadding
        )
        
        section.interGroupSpacing = 16 // vertical align full width will have multiple group in stead of item
        
        return section
    }
    
    // Favorites
    private func createNSCollectionLayoutSectionFavorites() -> NSCollectionLayoutSection {
        let sectionPadding: CGFloat = 24
        let shadowPadding: CGFloat = 8
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5), // two item per row
                heightDimension: .absolute(200)  // vertical control the height by item instead
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        /// Group = cell container

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(300) // vertical align need the group to extend as need
            ),
            subitems: [item]
        )
        
//        group.interItemSpacing = .fixed(16)
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: sectionPadding - shadowPadding,
            bottom: 0,
            trailing: sectionPadding - shadowPadding
        )
        
        /// Section = Section container: header, footer can be shown

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // vertical align use main scroll
        
        section.interGroupSpacing = 0 // vertical align full width will have multiple group in stead of item
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(62)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        header.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: sectionPadding,
            bottom: 0,
            trailing: sectionPadding
        )
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}
