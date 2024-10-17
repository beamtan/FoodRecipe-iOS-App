//
//  JsonReader.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 23/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import Foundation

public func loadJson<T: Decodable>(fileName: String, type: T.Type) -> T? {
    if let path = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    
    return nil
}
