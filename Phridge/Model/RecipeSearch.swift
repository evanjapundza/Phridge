//
//  RecipeSearch.swift
//  Phridge
//
//  Created by Evan Japundza on 1/25/23.
//

import Foundation

struct RecipeSearch: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var place: String
    var profilePic: String
}

struct Recipe: Decodable {
    let id: Int
    let title: String
    let image: String
    let usedIngredientCount: Int
    let missedIngredientCount: Int
    let missedIngredients: [Ingredient]
    let usedIngredients: [Ingredient]
}

struct Ingredient: Decodable {
    let id: Int
    let name: String
    var isSelected: Bool
}



class RecipeSearchModel {
    
    init() {
        
    }
    
    func searchByIngredients(ingredients: [Ingredient]) {
        
        let apiKey = "c0ac2e8debc54a66b15c972fd0520913"
        
        var ingredientNames: [String] = []
        
        for ingr in ingredients {
            ingredientNames.append(ingr.name)
        }
        
        let searchIngredients = ingredientNames.joined(separator: ",")
        
        let url = URL(string: "https://api.spoonacular.com/recipes/findByIngredients?apiKey=\(apiKey)&ingredients=\(searchIngredients)&ranking=1")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
}


