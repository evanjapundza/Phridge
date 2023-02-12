//
//  StartModel.swift
//  Phridge
//
//  Created by Evan Japundza on 2/11/23.
//

import Foundation
import SwiftUI

class StartModel {
    
    @ObservedObject public var startData = RecipeSearchViewModel()
    
    func searchByIngredients(ingredients: [Ingredient]) {
        
        let apiKey = "c0ac2e8debc54a66b15c972fd0520913"
        
        var ingredientNames: [String] = []
        
        for ingr in ingredients {
            let tempString = ingr.name.replacingOccurrences(of: " ", with: "+")
            ingredientNames.append(tempString)
        }
        
        let searchIngredients = ingredientNames.joined(separator: ",+")
        
        
        let task = URLSession.shared.dataTask(with:  URL(string: "https://api.spoonacular.com/recipes/findByIngredients?apiKey=\(apiKey)&ingredients=\(searchIngredients)&number=30")!) { (data, response, error) in
            if let data = data {
                do {
                    let recipes = try JSONDecoder().decode([Recipe].self, from: data)
                    for recipe in recipes {
                        DispatchQueue.main.async {
                            self.startData.fetched_users.append(recipe)
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func doSwipe(rightSwipe: Bool = false) {
        
        guard let first = startData.fetched_users.first else {
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("BUTTONACTION"), object: nil, userInfo: [
            
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
    
}
