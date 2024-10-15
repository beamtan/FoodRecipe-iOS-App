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
        case logout = 3
    }
    
    enum Settings: Int, CaseIterable {
        case setting1
        case setting2
        case setting3
        case setting4
        case setting5
        
        var displayName: String {
            switch self {
            case .setting1:
                return "Notifications"
            case .setting2:
                return "Privacy & Security"
            case .setting3:
                return "Help & Support"
            case .setting4:
                return "Appearance"
            case .setting5:
                return "Languages"
            }
        }
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
            case .logout:
                return createNSCollectionLayoutSectionLogout()
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
        
        /// Logout
        collectionView.register(
            UINib(nibName: "LogoutCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "LogoutCollectionViewCell"
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
            return Settings.allCases.count
        }
        
        if section == Sections.logout.rawValue {
            return 1
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
            
            if let setting = Settings(rawValue: indexPath.row) {
                cell.setup(labelText: setting.displayName)
            }
            
            if indexPath.row == 0 {
                cell.makeTopRoundCorner()
            }
            
            if indexPath.row == Settings.allCases.count - 1 {
                cell.makeBottomRoundCorner()
            }
            
            return cell
        }
        
        if indexPath.section == Sections.logout.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LogoutCollectionViewCell", for: indexPath) as! LogoutCollectionViewCell
            
            cell.logoutClosure = { [weak self] in
                guard let self else { return }
                
                router?.routeToLogin()
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}
