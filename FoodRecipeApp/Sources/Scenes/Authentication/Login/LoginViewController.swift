//
//  LoginViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayLoginWithFirebaseSuccess(viewModel: LoginModels.FirebaseLogin.ViewModel)
    func displayLoginWithFirebaseFailure(viewModel: LoginModels.FirebaseLogin.ViewModel)
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
    
    @IBOutlet weak var emailBorderView: UIView!
    @IBOutlet weak var passwordBorderView: UIView!
    
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
        startLoadingLottie()
        
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        
        let request = LoginModels.FirebaseLogin.Request(email: email, password: password)
        interactor?.loginWithFirebase(request: request)
    }
    
    @objc func loginWithGooglePressed() {
        googleService.signUp(viewController: self) { [weak self] in
            guard let self else {
                return
            }
            
            googleService.getFirebaseUser() { user in
                print("Welcome: \(user?.email ?? "")")
                print("isAnonymous \(user?.isAnonymous ?? true)")
           }
        }
    }
    
    @IBAction func byPassToHome(_ sender: Any) {
        router?.routeToHome()
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
    
    private func showValidate() {
        emailBorderView.layer.borderColor = UIColor.red.cgColor
        emailBorderView.layer.borderWidth = 1
        
        passwordBorderView.layer.borderColor = UIColor.red.cgColor
        passwordBorderView.layer.borderWidth = 1
    }
    
    private func clearValidate() {
        emailBorderView.layer.borderWidth = 0
        passwordBorderView.layer.borderWidth = 0
    }
    
    private func changeButtonState(textField: UITextField, updatedText: String) {
        clearValidate()
        
        if textField == emailTextField {
            if isEmailValid(updatedText) &&
                passwordTextField.text?.count ?? 0 >= 9 {
                enableRegisterButton()
            } else {
                disableRegisterButton()
            }
        }
        
        if textField == passwordTextField {
            if updatedText.count >= 9 &&
                isEmailValid(emailTextField.text ?? "") {
                enableRegisterButton()
            } else {
                disableRegisterButton()
            }
        }
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
    
    private func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isPassWordValid() -> Bool {
        return passwordTextField.text != ""
    }
    
    // MARK: - Display
    
    func displayLoginWithFirebaseSuccess(viewModel: LoginModels.FirebaseLogin.ViewModel) {
        stopLoadingLottie()
        
        guard let user = viewModel.data else {
            return
        }
        
        let request = LoginModels.FirebaseUser.Request(user: user)
        
        interactor?.saveUserToFirebaseUser(request: request)
        router?.routeToHome()
    }
    
    func displayLoginWithFirebaseFailure(viewModel: LoginModels.FirebaseLogin.ViewModel) {
        showValidate()
        stopLoadingLottie()
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
        
        changeButtonState(textField: textField, updatedText: updatedText)
        
        return true
    }
}
