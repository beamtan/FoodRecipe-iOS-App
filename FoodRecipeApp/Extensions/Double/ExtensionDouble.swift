//
//  ExtensionDouble.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 18/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import Foundation

extension Double {
    func rounding(decimal: Int = 2, roundingMode: NumberFormatter.RoundingMode = .down) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = decimal
        formatter.minimumFractionDigits = decimal
        formatter.roundingMode = roundingMode
        if let str = formatter.string(for: self) {
            return str
        } else {
            return ""
        }
    }
}
