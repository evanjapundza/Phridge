//
//  RecipeSearchViewModel.swift
//  Phridge
//
//  Created by Evan Japundza on 1/25/23.
//

import SwiftUI

class RecipeSearchViewModel: ObservableObject {
    
    @Published var fetched_users: [Recipe] = []
    @Published var ingredient_list: [Int: Ingredient] = [:]
    
    
    init() {
        fetched_users.append(Recipe(id: 00001, title: "Testing Card", image: "highres1", usedIngredientCount: 0, missedIngredientCount: 0))
        fetched_users.append(Recipe(id: 00002, title: "Testing Card 2", image: "highres1", usedIngredientCount: 0, missedIngredientCount: 0))
    }
    
    func getIndex(user: Recipe)->Int {
        
        let index = fetched_users.firstIndex(where: {currentUser in
            return user.id == currentUser.id
        }) ?? 0
        
        return index
    }
}
