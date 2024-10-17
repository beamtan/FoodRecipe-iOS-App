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
        
        navigationController?.setNavigationBarHidden(true, animated: true)
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
        UserDefaultService.shared.removeAll(completionHandler: nil)
    }
}

// MARK: - Switching Tab Animation
// Thanks to https://gist.github.com/illescasDaniel/6689461ccd396f0536e4f2e5f43befe8

extension HomeTabbarViewController {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if let fromView = tabBarController.selectedViewController?.view,
           let toView = viewController.view, fromView != toView,
           let controllerIndex = self.viewControllers?.firstIndex(of: viewController) {
            
            let viewSize = fromView.frame
            let scrollRight = controllerIndex > tabBarController.selectedIndex
            
            // Avoid UI issues when switching tabs fast
            if fromView.superview?.subviews.contains(toView) == true { return false }
            
            fromView.superview?.addSubview(toView)
            
            let screenWidth = UIScreen.main.bounds.size.width
            toView.frame = CGRect(
                x: (scrollRight ? screenWidth : -screenWidth),
                y: viewSize.origin.y,
                width: screenWidth,
                height: viewSize.size.height
            )
            
            UIView.animate(
                withDuration: 0.25,
                delay: TimeInterval(0.0),
                options: [.curveEaseOut, .preferredFramesPerSecond60],
                animations: {
                    fromView.frame = CGRect(
                        x: (scrollRight ? -screenWidth : screenWidth),
                        y: viewSize.origin.y,
                        width: screenWidth,
                        height: viewSize.size.height
                    )
                    toView.frame = CGRect(
                        x: 0,
                        y: viewSize.origin.y,
                        width: screenWidth,
                        height: viewSize.size.height
                    )
                },
                completion: { finished in
                if finished {
                    fromView.removeFromSuperview()
                    tabBarController.selectedIndex = controllerIndex
                }
            })
            
            return true
        }
        
        return false
    }
}
