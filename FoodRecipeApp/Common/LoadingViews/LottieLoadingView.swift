//
//  LottieLoadingView.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 16/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit
import Lottie
import SwiftMessages

class LottieLoadingView: MessageView {
    @IBOutlet weak var loadingView: UIView! {
        didSet {
            let animationView = LottieAnimationView(name: "animationCook")
            animationView.frame = loadingView.bounds
            animationView.loopMode = .loop
            animationView.animationSpeed = 1
            animationView.play()
            
            loadingView.addSubview(animationView)
        }
    }
}
