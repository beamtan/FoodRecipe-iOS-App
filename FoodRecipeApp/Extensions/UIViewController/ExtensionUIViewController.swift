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
    
    // MARK: - Loading
    
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
    
    // MARK: - Toast
    
    func showSuccessToast() {
        let view = MessageView.viewFromNib(layout: .messageView)

        // Theme message elements with the warning style.
        view.configureTheme(.success)

        // Add a drop shadow.
        view.configureDropShadow()

        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
//        view.configureContent(title: "Success", body: "", iconText: "✅")
        view.configureContent(title: "Success", body: "You have successfully change name.")
        view.button?.isHidden = true

        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10

        // Show the message.
        SwiftMessages.show(view: view)
    }
}
