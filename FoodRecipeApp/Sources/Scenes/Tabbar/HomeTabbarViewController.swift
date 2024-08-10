//
//  HomeTabbarViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

class HomeTabbarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        selectedIndex = 0

        setupMiddleButton()
        
        tabBar.tintColor = ._70_B_9_BE
        tabBar.unselectedItemTintColor = UIColor.gray
    }

    func setupMiddleButton() {
        let middleButton = UIButton(
            frame: CGRect(
                x: (self.view.bounds.width / 2) - 28 ,
                y: -32,
                width: 56,
                height: 56
            )
        )
        
        let cookImage = UIImage(systemName: "frying.pan")
        let tintedCookImage = cookImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        middleButton.setImage(tintedCookImage, for: .normal)
        
        middleButton.backgroundColor = ._0_A_2533
        middleButton.layer.cornerRadius = 28
        
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        middleButton.layer.shadowOpacity = 0.1
        
        middleButton.addTarget(self, action: #selector(middleButtonPressed), for: .touchUpInside)
        
        tabBar.addSubview(middleButton)
        
        view.layoutIfNeeded()
    }
    
    @objc func middleButtonPressed() {
        print("im here")
    }
}
