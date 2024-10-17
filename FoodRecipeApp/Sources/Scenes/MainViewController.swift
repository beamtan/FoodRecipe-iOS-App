//
//  MainViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 3/8/2567 BE.
//

import UIKit
import Pageboy

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - IBOutet
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    @IBAction func loginPressed(_ sender: UIButton) {
        showAuthenticationBottomSheet(whichPage: .last)
    }
    
    @IBAction func createNewAccountPressed(_ sender: UIButton) {
        showAuthenticationBottomSheet(whichPage: .first)
    }
    
    // MARK: - Functions
    
    private func showAuthenticationBottomSheet(whichPage: PageboyViewController.Page) {
        guard let destinationViewController = UIStoryboard(name: "AuthenticationStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AuthenticationViewController") as? AuthenticationViewController else {
            return
        }
        
        destinationViewController.whichPage = whichPage
        
        showBottomSheet(
            destinationViewController,
            isDisableCloseByTouchOutside: false,
            detents: [
                .custom(resolver: { (context) in
                    return 576
                })]
        )
    }
    
    private func showBottomSheet<T: UIViewController>(
        _ viewController: T,
        isDisableCloseByTouchOutside: Bool = false,
        detents: [UISheetPresentationController.Detent]
    ) {
        viewController.modalPresentationStyle = .pageSheet
        viewController.isModalInPresentation = isDisableCloseByTouchOutside
        
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = detents
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 15
        }
        
        present(viewController, animated: true)
    }
}

