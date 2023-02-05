//
//  RecipeSearchViewModel.swift
//  Phridge
//
//  Created by Evan Japundza on 1/25/23.
//

import SwiftUI

class RecipeSearchViewModel: ObservableObject {
    
    @Published var fetched_users: [RecipeSearch] = []
    
    @Published var displaying_users: [RecipeSearch]?
    
    init(){
        
        
        fetched_users = [
            RecipeSearch(name: ".", place: ".", profilePic: "highres"),
            RecipeSearch(name: ".", place: ".", profilePic: "highres2"),
            RecipeSearch(name: ".", place: ".", profilePic: "highres3"),
            RecipeSearch(name: ".", place: ".", profilePic: "highres4"),
            RecipeSearch(name: ".", place: ".", profilePic: "highres5")
        ]

        displaying_users = fetched_users
    }
    
    func getIndex(user: RecipeSearch)->Int {
        
        let index = displaying_users?.firstIndex(where: {currentUser in
            return user.id == currentUser.id
        }) ?? 0
        
        return index
    }
}
