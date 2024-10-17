//
//  EditProfileRouter.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 17/10/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@objc protocol EditProfileRoutingLogic {
    
}

protocol EditProfileDataPassing {
    var dataStore: EditProfileDataStore? { get }
}

class EditProfileRouter: NSObject, EditProfileRoutingLogic, EditProfileDataPassing {
    weak var viewController: EditProfileViewController?
    var dataStore: EditProfileDataStore?
}
