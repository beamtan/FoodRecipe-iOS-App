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
        
        middleButton.setBackgroundImage(UIImage(named: "food"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        middleButton.layer.shadowOpacity = 0.1
        
        tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(middleButtonPressed), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    
    @objc func middleButtonPressed() {
        print("im here")
    }
}
