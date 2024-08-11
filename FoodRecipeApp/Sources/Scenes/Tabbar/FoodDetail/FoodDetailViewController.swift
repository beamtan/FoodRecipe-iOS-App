//
//  FoodDetailViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 11/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol FoodDetailDisplayLogic: AnyObject {
    func displaySomething(viewModel: FoodDetailModels.Something.ViewModel)
}

class FoodDetailViewController: UIViewController, FoodDetailDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: FoodDetailBusinessLogic?
    var router: (NSObjectProtocol & FoodDetailRoutingLogic & FoodDetailDataPassing)?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var foodImageView: UIImageView!
    
    @IBOutlet weak private var foodImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var foodImageViewTopPadding: NSLayoutConstraint!
    
    @IBOutlet weak private var ingredientsButton: UIButton!
    @IBOutlet weak private var instructionsButton: UIButton!
    
    @IBOutlet weak private var cardStackView: UIStackView!
    @IBOutlet weak private var headerView: UIView!
    @IBOutlet weak var closeButtonClearBG: UIButton!
    @IBOutlet weak var closeButtonSolidBG: UIButton!
    
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
        
        createIngredientCard()
    }
    
    // MARK: - IBAction
    
    @IBAction func ingredientsButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            UIView.animate(withDuration: 0.1) {
                self.instructionsButton.backgroundColor = .E_6_EBF_2
                self.instructionsButton.setTitleColor(.green, for: .normal)
                
                sender.backgroundColor = ._042628
                sender.setTitleColor(.orange, for: .normal)
            }
        }
    }
    
    @IBAction func instructionsButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            UIView.animate(withDuration: 0.1) {
                self.ingredientsButton.backgroundColor = .E_6_EBF_2
                self.ingredientsButton.setTitleColor(.purple, for: .normal)
                
                sender.backgroundColor = ._042628
                sender.setTitleColor(.systemPink, for: .normal)
            }
        }
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func closeButton2Pressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: - General Function
    
    private func createIngredientCard(image: UIImage? = nil, name: String = "") {
        for i in 1...10 {
            // Create the container view
            let customView = UIView()
            customView.backgroundColor = .white
            customView.layer.cornerRadius = 12
            customView.layer.shadowColor = UIColor.black.cgColor
            customView.layer.shadowOpacity = 0.1
            customView.layer.shadowOffset = CGSize(width: 0, height: 4)
            customView.layer.shadowRadius = 6
            customView.translatesAutoresizingMaskIntoConstraints = false
            
            let imageContainerView = UIView()
            imageContainerView.backgroundColor = .E_6_EBF_2
            imageContainerView.layer.cornerRadius = 8
            imageContainerView.layer.masksToBounds = true
            imageContainerView.translatesAutoresizingMaskIntoConstraints = false
            
            // Create the image view
            let imageView = UIImageView()
            imageView.image = UIImage(named: "avocadoImage")
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            // Create the label
            let nameLabel = UILabel()
            nameLabel.text = "Avocado"
            nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            nameLabel.textColor = .black
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // Add image view and label to the custom view
            imageContainerView.addSubview(imageView)
            customView.addSubview(imageContainerView)
            customView.addSubview(nameLabel)
            
            // Set constraints for the image view
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 30),
                imageView.heightAnchor.constraint(equalToConstant: 30)
            ])
            
            // Set constraints for the imageContainerView view
            NSLayoutConstraint.activate([
                imageContainerView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16),
                imageContainerView.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
                imageContainerView.widthAnchor.constraint(equalToConstant: 40),
                imageContainerView.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            // Set constraints for the label
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: 16),
                nameLabel.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
                nameLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16)
            ])
            
            // Set height constraint for the custom view
            customView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
            // Add the custom view to the stack view
            cardStackView.addArrangedSubview(customView)
        }
    }
    
    private func setup() {
        let viewController = self
        let interactor = FoodDetailInteractor()
        let presenter = FoodDetailPresenter()
        let router = FoodDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func doSomething() {
        let request = FoodDetailModels.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    // MARK: - Display
    
    func displaySomething(viewModel: FoodDetailModels.Something.ViewModel) {
    }
    
    // MARK: - Navigation
    

}

// MARK: - UIScrollViewDelegate

extension FoodDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y // down = -, up = +
        
        let originSheetY: CGFloat = -59.0
        let intersectionPointOfSheetAndHeader: CGFloat = 93
        
        let isImageBeginStretch: Bool = offsetY < originSheetY
        let isHeaderShow: Bool = offsetY > intersectionPointOfSheetAndHeader
        let isHeaderViewAlreadyHidden: Bool = headerView.layer.opacity == 0
        
        // In which any way image will change by height or padding eventually
        
        if isImageBeginStretch {
            // Stretching mean image is only getting bigger so the different should be positive only
            
            let differentBetweenSheetAndImage: CGFloat = abs(offsetY) - abs(originSheetY)
            let imageOriginHeight: CGFloat = 280
            
            foodImageViewHeight.constant = imageOriginHeight + differentBetweenSheetAndImage
        } else {
            let differentBetweenSheetAndImage: CGFloat = offsetY - originSheetY
            let isUpDirection: Bool = differentBetweenSheetAndImage > 0
            
            if isUpDirection && !isHeaderShow {
                // Divide by 2 for slower rate compare to sheet
                // Make it negative for up direction
                
                foodImageViewTopPadding.constant = (differentBetweenSheetAndImage / 3) * -1
            }
        }
        
        if isHeaderShow {
            let differentSheetAndHeaderOverlap: CGFloat = abs(intersectionPointOfSheetAndHeader) - abs(offsetY)
            
            // To make opacity from the different point of y
            // Divide by 100 to make the different smoothly with ratio as 0 is min opacity and 1 is max opacity
            
            headerView.layer.opacity = Float(min(abs(differentSheetAndHeaderOverlap) / 100, 1))
            closeButtonSolidBG.layer.opacity = Float((1 - (abs(differentSheetAndHeaderOverlap) / 100)))
            
            return
        }
        
        if isHeaderViewAlreadyHidden {
            return
        }
        
        headerView.layer.opacity = 0
    }
}
