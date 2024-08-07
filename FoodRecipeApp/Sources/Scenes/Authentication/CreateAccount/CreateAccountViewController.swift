//
//  CreateAccountViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol CreateAccountDisplayLogic: AnyObject {
    
}

class CreateAccountViewController: UIViewController, CreateAccountDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: CreateAccountBusinessLogic?
    var router: (NSObjectProtocol & CreateAccountRoutingLogic & CreateAccountDataPassing)?
    
    let googleService: GoogleServiceImp = GoogleService()
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signUpWithGoogleView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(signUpWithGooglePressed))
            signUpWithGoogleView.addGestureRecognizer(gesture)
        }
    }
    
    @IBOutlet weak var nameBorderView: UIView!
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
    
    @IBAction func registerPressed(_ sender: UIButton) {
        let _: String = nameTextField.text ?? ""
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        
        googleService.createUser(email: email, password: password) { [weak self] in
            guard let self else { return }
            
            googleService.seeUserDetail() { user in
                print("Welcome: \(user?.email ?? "")")
                print("isAnonymous \(user?.isAnonymous ?? true)")
           }
        }
    }
    
    @objc func signUpWithGooglePressed() {
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
        let interactor = CreateAccountInteractor()
        let presenter = CreateAccountPresenter()
        let router = CreateAccountRouter()
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
        
        if textField == nameTextField {
            if updatedText == "" &&
                passwordTextField.text?.count ?? 0 >= 9 &&
                isEmailValid(emailTextField.text ?? "") {
                enableRegisterButton()
            } else {
                disableRegisterButton()
            }
        }
        
        if textField == emailTextField {
            if isEmailValid(updatedText) &&
                passwordTextField.text?.count ?? 0 >= 9 &&
                nameTextField.text != "" {
                enableRegisterButton()
            } else {
                disableRegisterButton()
            }
        }
        
        if textField == passwordTextField {
            if updatedText.count >= 9 &&
                isEmailValid(emailTextField.text ?? "") &&
                nameTextField.text != "" {
                enableRegisterButton()
            } else {
                disableRegisterButton()
            }
        }
    }
    
    private func enableRegisterButton() {
        registerButton.backgroundColor = ._32_B_768
        registerButton.isEnabled = true
        registerButton.tintColor = .white
    }
    
    private func disableRegisterButton() {
        registerButton.backgroundColor = .F_4_F_4_F_4
        registerButton.isEnabled = false
        registerButton.tintColor = ._9_CA_3_AF
    }
    
    private func isNameValid() -> Bool {
        return nameTextField.text != ""
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isPassWordValid() -> Bool {
        return passwordTextField.text?.count ?? 0 >= 10
    }
    
    // MARK: - Display
    

}

extension CreateAccountViewController: UITextFieldDelegate {
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
