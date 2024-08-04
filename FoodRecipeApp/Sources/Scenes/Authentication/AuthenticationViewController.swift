//
//  AuthenticationViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 4/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

protocol AuthenticationDisplayLogic: AnyObject {
    
}

class AuthenticationViewController: TabmanViewController, AuthenticationDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: AuthenticationBusinessLogic?
    var router: (NSObjectProtocol & AuthenticationRoutingLogic & AuthenticationDataPassing)?
    
    private let viewControllerInfo: [(storyboardName: String, identifier: String, type: UIViewController.Type)] = [
        ("LoginStoryboard", "LoginViewController", LoginViewController.self),
        ("CreateAccountStoryboard", "CreateAccountViewController", CreateAccountViewController.self),
    ]
    
    private lazy var viewControllers: [UIViewController] = viewControllerInfo.lazy.map { info in
        let storyboard = UIStoryboard(name: info.storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: info.identifier)
        
        return viewController
    }
    
    var whichPage: PageboyViewController.Page?
    
    // MARK: - IBOutlet
    
    
    
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

        createTabBar()
    }
    
    // MARK: - IBAction
    
    
    
    // MARK: - Function
    
    private func setup() {
        let viewController = self
        let interactor = AuthenticationInteractor()
        let presenter = AuthenticationPresenter()
        let router = AuthenticationRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func createTabBar(){
        dataSource = self
        isScrollEnabled = false

        // Create a bar
        let buttonBar = TMBarView.ButtonBar()
        buttonBar.backgroundView.style = .clear
        buttonBar.layout.contentMode = .fit
        buttonBar.layout.alignment = .leading
        buttonBar.layout.contentInset = .init(top: 50, left: 16, bottom: 0, right: 16)
        buttonBar.indicator.weight = .light
        buttonBar.indicator.cornerStyle = .rounded
        buttonBar.indicator.overscrollBehavior = .compress
        buttonBar.indicator.tintColor = .systemGreen
        
        buttonBar.buttons.customize {
            $0.tintColor = .gray
            $0.font = UIFont(name: "Inter-SemiBold", size: 16) ?? .boldSystemFont(ofSize: 16)
            $0.selectedFont = UIFont(name: "Inter-SemiBold", size: 16)
            $0.selectedTintColor = .systemGreen
        }
        
        let systemBar = buttonBar.systemBar()
        systemBar.backgroundStyle = .flat(color: .clear)
        systemBar.separatorColor = .clear
        
        addBar(systemBar, dataSource: self, at: .top)
    }
}

extension AuthenticationViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return whichPage
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let buttonBarItems: [String] = [
            "Create Account",
            "Login"
        ]
        return TMBarItem(title: buttonBarItems[index])
    }
}
