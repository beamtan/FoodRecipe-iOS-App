//
//  Extension+UIViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 16/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import SwiftMessages

extension UIViewController {
    func startLoadingLottie() {
        let view: LottieLoadingView = try! SwiftMessages.viewFromNib()
        var config = SwiftMessages.defaultConfig
        view.configureDropShadow()
        view.id = "LoadingLottie"
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        config.duration = .forever
        config.presentationStyle = .center
        config.dimMode = .color(color: .clear, interactive: false)
        config.interactiveHide = false
        
        SwiftMessages.show(config: config, view: view)
    }
    
    func stopLoadingLottie() {
        SwiftMessages.hide(id: "LoadingLottie")
    }
}
