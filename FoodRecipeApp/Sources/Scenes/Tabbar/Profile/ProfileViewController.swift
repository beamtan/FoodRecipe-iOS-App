//
//  ProfileViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol ProfileDisplayLogic: AnyObject {
    
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {
    
    enum Sections: Int, CaseIterable {
        case accountTitle = 0
        case account = 1
        case setting = 2
    }
    
    // MARK: - Properties
    
    var interactor: ProfileBusinessLogic?
    var router: (NSObjectProtocol & ProfileRoutingLogic & ProfileDataPassing)?
    
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
            case .setting:
                return createNSCollectionLayoutSectionSetting()
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
        
        /// Setting
        collectionView.register(
            UINib(nibName: "ProfileSettingCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "ProfileSettingCollectionViewCell"
        )
    }
    
    // MARK: - Display
    
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
        
        if section == Sections.setting.rawValue {
            return 10
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
        
        if indexPath.section == Sections.setting.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileSettingCollectionViewCell", for: indexPath) as! ProfileSettingCollectionViewCell
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - NSCollectionLayoutSection Helper

extension ProfileViewController {
    
    // MARK: - Title
    
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
    
    // MARK: - Account
    
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
    
    // MARK: - Setting
    
    private func createNSCollectionLayoutSectionSetting() -> NSCollectionLayoutSection {
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
                heightDimension: .absolute(50) // vertical align need the group to extend as need
            ),
            subitems: [item]
        )
        
        // Section = Section container: header, footer can be shown
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // vertical align use main scroll
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        section.interGroupSpacing = 0 // vertical align full width will have multiple group in stead of item
        
        return section
    }
}
