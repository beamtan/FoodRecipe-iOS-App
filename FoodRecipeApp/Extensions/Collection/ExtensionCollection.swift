//
//  ExtensionCollection.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 16/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
