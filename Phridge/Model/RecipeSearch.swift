//
//  RecipeSearch.swift
//  Phridge
//
//  Created by Evan Japundza on 1/25/23.
//

import Foundation


struct Recipe: Decodable {
    let id: Int
    let title: String
    let image: String
    let usedIngredientCount: Int
    let missedIngredientCount: Int
}

struct Ingredient: Decodable {
    let id: Int
    let name: String
    var isSelected: Bool
}


