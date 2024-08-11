//
//  ProfileViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol ProfileDisplayLogic: AnyObject {
    func displaySomething(viewModel: ProfileModels.Something.ViewModel)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: ProfileBusinessLogic?
    var router: (NSObjectProtocol & ProfileRoutingLogic & ProfileDataPassing)?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var profileCardView: UIView! {
        didSet {
            profileCardView.layer.shadowColor = UIColor.black.cgColor
            profileCardView.layer.shadowOpacity = 0.1
            profileCardView.layer.shadowOffset = CGSize(width: 0, height: 1)
            profileCardView.layer.shadowRadius = 2
        }
    }
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var profileNameLabel: UILabel!
    @IBOutlet weak private var profileRole: UILabel!
    
    @IBOutlet weak var profileFavCollectionView: UICollectionView!
    
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
    
    func doSomething() {
        let request = ProfileModels.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    // MARK: - Display
    
    func displaySomething(viewModel: ProfileModels.Something.ViewModel) {
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = profileFavCollectionView.dequeueReusableCell(
            withReuseIdentifier: ProfileFavCollectionViewCell.identifier,
            for: indexPath
        ) as! ProfileFavCollectionViewCell
        
        return cell
    }
    
    /// 1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        /// 2
        return UIEdgeInsets(top: 1.0, left: 24.0, bottom: 1.0, right: 24.0)
    }
    
    /// 3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// 4
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        /// 5
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        /// 6
        return CGSize(width: widthPerItem - 24.0, height: 198)
    }
}
