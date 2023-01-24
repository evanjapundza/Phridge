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
                LinearGradient(colors: [Color(0x9600ff), Color(0xAEBA)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Button {
                        print("but 1")
                    } label: {
                        Text("Ingredient List")
                    }
                    .frame(width: 150, height: 25)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(10)
                    
                    Button {
                        print("but 2")
                    } label: {
                        Text("Favorites")
                    }
                    .frame(width: 150, height: 25)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(10)
                    
                    Spacer()
                }

                
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
