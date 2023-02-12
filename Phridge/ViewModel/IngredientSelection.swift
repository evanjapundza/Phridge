//
//  IngredientSelection.swift
//  Phridge
//
//  Created by Evan Japundza on 1/29/23.
//

import Foundation
import SwiftUI
import CSV


let stream = InputStream(fileAtPath: Bundle.main.path(forResource: "top-1k-ingredients", ofType: "csv")!)!
let csv = try! CSVReader(stream: stream)


var ingredientDictionary: [Int: Ingredient] = [:]
var selectedIngredientDictionary: [Int: Ingredient] = [:]



class Selection: ObservableObject {
    @Published var showSelection = false
}

struct IngredientListRows: View {
    
    
    var ingredient: Ingredient
    
    @Binding var selectedIngredients: Set<Int>
    
    var isSelected: Bool {
        selectedIngredients.contains(ingredient.id)
    }
    
    var body: some View {
        HStack {
            Text(self.ingredient.name)
            Spacer()
            if self.isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.blue)
            }
        }
        .onTapGesture {
            if self.isSelected {
                self.selectedIngredients.remove(self.ingredient.id)
                selectedIngredientDictionary.removeValue(forKey: ingredient.id)
            }
            else {
                self.selectedIngredients.insert(self.ingredient.id)
                selectedIngredientDictionary[ingredient.id] = ingredient
            }
        }
    }
    
}


struct IngredientSelection: View {
    
    @State private var searchText = ""
    @State private var selectedRows = Set<Int>()
    
    var filteredIngredients: [Int: Ingredient] {
        if searchText == "" {
            return selectedIngredientDictionary
        }
        
        else {
            return ingredientDictionary.filter {
                $0.value.name.contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                List(Array(filteredIngredients.keys), id: \.self, selection: $selectedRows) { key in
                    IngredientListRows(ingredient: filteredIngredients[key]!, selectedIngredients: self.$selectedRows)
                }
                .searchable(text: $searchText)
                
            }

        }
    }
    
    mutating func populateIngredientList() {
        
        if ingredientDictionary.isEmpty {
            while let row = csv.next() {
                let ingr = Ingredient(id: Int(row[1])!, name: row[0], isSelected: false)
                ingredientDictionary[ingr.id] = ingr
                
            }
        }
        

        
    }
}

struct IngredientSelection_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSelection()
    }
}
