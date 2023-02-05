//
//  Menu.swift
//  Phridge
//
//  Created by Evan Japundza on 1/22/23.
//

import SwiftUI

struct Menu: View {
    
    @Binding var isSidebarVisible: Bool
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7
    @State var temp1 = IngredientSelection()
    @ObservedObject var select = Selection()
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.6))
            .opacity(isSidebarVisible ? 1 : 0)
            .transition(AnyTransition.slide)
            .animation(.default.delay(0.1), value: isSidebarVisible)
            .onTapGesture {
                isSidebarVisible.toggle()
                
            }
            
            
            content
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        
        HStack {
            ZStack {
                LinearGradient(colors: [Color(0xd9adfa), Color(0x9969C7), Color(0x6A359C)], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Button(action: {
                        temp1.populateIngredientList()
                        select.showSelection.toggle()
                    }) {
                        HStack{
                            Image(systemName: "pencil")
                                .foregroundColor(Color.white)
                            Text("Edit Ingredients")
                                .foregroundColor(Color.white)
                                .font(Font.headline.weight(.bold))
                                //.background(Color.blue)
                                //.cornerRadius(10)
                        }
                        .frame(width: 250, height: 25)
                        .padding(10)
                        
                    }
                    .sheet(isPresented: $select.showSelection) {
                        IngredientSelection()
                    }
                    
                    
                    
                    
                    Button {
                        print("but 2")
                    } label: {
                        HStack {
                            Image(systemName: "star")
                                .foregroundColor(Color.white)
                            Text("Favorites")
                                .font(Font.headline.weight(.bold))
                        }
                    }
                    .frame(width: 250, height: 25)
                    .padding(10)
                    .foregroundColor(Color.white)
                    //.background(Color.blue)
                    //.cornerRadius(10)
                    
                    Spacer()
                }
                .padding(.vertical, 100)
                
                
            }
            .frame(width: sideBarWidth)
            .offset(x: isSidebarVisible ? 0 : -sideBarWidth)
            .animation(.default, value: isSidebarVisible)
            
            Spacer()
        }
  
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu(isSidebarVisible: .constant(false))
    }
}
