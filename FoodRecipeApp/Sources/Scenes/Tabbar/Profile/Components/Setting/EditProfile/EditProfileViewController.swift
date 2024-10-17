//
//  EditProfileViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 17/10/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import SwiftMessages

protocol EditProfileDisplayLogic: AnyObject {
    func displayInquiryUser(viewModel: EditProfileModels.User.ViewModel)
    func displayUpdateProfileSuccess(viewModel: EditProfileModels.UpdateUser.ViewModel)
    func displayUpdateProfileFailure(viewModel: EditProfileModels.UpdateUser.ViewModel)
}

class EditProfileViewController: UIViewController, EditProfileDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: EditProfileBusinessLogic?
    var router: (NSObjectProtocol & EditProfileRoutingLogic & EditProfileDataPassing)?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var backButtonView: UIView!
    @IBOutlet weak private var displayNameLabel: UILabel!
    
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var displayNameTextField: UITextField!
    
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
        
        setupView()
        inquiryUser()
    }
    
    // MARK: - IBAction
    
    @IBAction private func confirmPressed(_ sender: UIButton) {
        updateUser()
    }
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = EditProfileInteractor()
        let presenter = EditProfilePresenter()
        let router = EditProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setupView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backButtonPressed))
        backButtonView.addGestureRecognizer(gesture)
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Use Cases
    
    private func inquiryUser() {
        let request = EditProfileModels.User.Request()
        interactor?.inquiryUser(request: request)
    }
    
    private func updateUser() {
        guard displayNameTextField.text != "" else { return }
        
        startLoadingLottie()
        
        let displayName = displayNameTextField.text ?? ""
        let request = EditProfileModels.UpdateUser.Request(displayName: displayName)
        
        interactor?.updateUserProfile(request: request)
    }
    
    // MARK: - Display
    
    func displayInquiryUser(viewModel: EditProfileModels.User.ViewModel) {
        displayNameLabel.text = viewModel.displayName
        displayNameTextField.text = viewModel.displayName
        emailTextField.text = viewModel.email
        
        stopLoadingLottie()
    }
    
    func displayUpdateProfileSuccess(viewModel: EditProfileModels.UpdateUser.ViewModel) {
        showSuccessToast()
        inquiryUser()
    }
    
    func displayUpdateProfileFailure(viewModel: EditProfileModels.UpdateUser.ViewModel) {
        stopLoadingLottie()
    }
    
    // MARK: - Navigation
}
