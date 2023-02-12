//
//  Start.swift
//  Phridge
//
//  Created by Evan Japundza on 1/16/23.
//

import SwiftUI
import UIKit

struct Start: View {
    
    
    @ObservedObject private var startData = RecipeSearchViewModel()
    @State private var showMenu = false
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7
    
    var myStartModel: StartModel = StartModel()

    @ObservedObject var selection = Selection()

    
    @State var temp1 = IngredientSelection()
    
    var body: some View {
        
        
        ZStack {
            
            NavigationView{
                ZStack {
                    
                    LinearGradient(colors: [Color(0xd9adfa), Color(0x9969C7), Color(0x6A359C)], startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                    
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                HStack {
                                    Button {
                                        showMenu.toggle()
                                        
                                    } label: {
                                        Image(systemName: "list.bullet")
                                            .foregroundColor(Color.black)
                                    }
                                    
                                    
                                }
                            }
                        }
                        .navigationBarTitle(Text("Phridge"), displayMode: .inline)
                    
                    HStack {
                        Button {
                            print("left swipe")
                            myStartModel.doSwipe()
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .font(.system(size: 60, weight: .bold))
                                .foregroundColor(Color(0xeb1c1c))
                                .shadow(radius: 5)
                                .padding()
                        }

                        
                        Button {
                            print("right swipe")
                            myStartModel.doSwipe(rightSwipe: true)
                        } label: {
                            Image(systemName: "heart.circle.fill")
                                .font(.system(size: 60, weight: .bold))
                                .foregroundColor(Color.green)
                                .shadow(radius: 5)
                                .padding()
                        }
                        

                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    //.disabled(startData.fetched_users)
                    .opacity((myStartModel.startData.fetched_users.isEmpty) ? 0.6 : 1)
                    
                    ZStack {
                        if let users = myStartModel.startData.fetched_users {
                            
                            if users.isEmpty {
                                VStack {
                                    Text("No matches left...enter more ingredients!")
                                        .font(.caption)
                                        .foregroundColor(Color.black)
                                    
                                    Button(action: {
                                        temp1.populateIngredientList()
                                        selection.showSelection.toggle()
                                    }) {
                                        Text("Edit Selection")
                                    }
                                    .frame(width: 150, height: 25)
                                    .padding()
                                    .foregroundColor(Color.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .sheet(isPresented: $selection.showSelection, onDismiss: {
                                        var testing: [Ingredient] = []
                                        for ing in selectedIngredientDictionary {
                                            testing.append(ing.value)
                                        }
                                        myStartModel.searchByIngredients(ingredients: testing)
                                    }) {
                                        IngredientSelection()
                                    }
                                    
                                    
                                }
                            }
                            else {
                                
                                ForEach(users.reversed(), id: \.id) { user in
                                    
                                    Swipe(startData: myStartModel.startData, user: user)
                                        .environmentObject(myStartModel.startData)
                                }
                            }
                        }
                        else {
                            ProgressView()
                        }
                    }
                    .padding(.vertical, 100)
                    .padding(.horizontal, 10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: -55)
                }

            }
            Menu(isSidebarVisible: $showMenu)
        }
    }
    
    
}

struct Start_Previews: PreviewProvider {
    static var previews: some View {
        Start()
    }
}


extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}
