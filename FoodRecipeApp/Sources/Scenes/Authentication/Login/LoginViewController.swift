//
//  LoginViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

protocol LoginDisplayLogic: AnyObject {
    func displaySomething(viewModel: LoginModels.Something.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    let googleService: GoogleServiceImp = GoogleService()
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginWithGoogleView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(loginWithGooglePressed))
            loginWithGoogleView.addGestureRecognizer(gesture)
        }
    }
    
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
    }
    
    // MARK: - IBAction
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        
        googleService.signIn(email: email, password: password) { [weak self] in
            guard let self else { return }
            
             googleService.seeUserDetail() { [weak self] user in
                 guard let self else { return }
                 
                 print("Welcome: \(user?.email ?? "")")
                 print("isAnonymous \(user?.isAnonymous ?? true)")
                 
                 router?.routeToHome()
            }
        }
    }
    
    @objc func loginWithGooglePressed() {
        googleService.signUp(viewController: self) { [weak self] in
            guard let self else {
                return
            }
            
            googleService.seeUserDetail() { user in
                print("Welcome: \(user?.email ?? "")")
                print("isAnonymous \(user?.isAnonymous ?? true)")
           }
        }
    }
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func enableRegisterButton() {
        loginButton.backgroundColor = ._32_B_768
        loginButton.isEnabled = true
        loginButton.tintColor = .white
    }
    
    private func disableRegisterButton() {
        loginButton.backgroundColor = .F_4_F_4_F_4
        loginButton.isEnabled = false
        loginButton.tintColor = ._9_CA_3_AF
    }
    
    private func isCreateAccountValid() -> Bool {
        return isEmailValid() && isPassWordValid()
    }
    
    private func isEmailValid() -> Bool {
        return emailTextField.text != ""
    }
    
    private func isPassWordValid() -> Bool {
        return passwordTextField.text != ""
    }
    
    // MARK: - Display
    
    func displaySomething(viewModel: LoginModels.Something.ViewModel) {
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let textInTextField = textField.text,
              let stringRange = Range(range, in: textInTextField) else {
            return false
        }
        
        let updatedText: String = textInTextField.replacingCharacters(in: stringRange, with: string)
        
        if isCreateAccountValid() {
            enableRegisterButton()
        } else {
            disableRegisterButton()
        }
        
        return true
    }
}
