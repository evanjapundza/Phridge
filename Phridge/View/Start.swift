//
//  Start.swift
//  Phridge
//
//  Created by Evan Japundza on 1/16/23.
//

import SwiftUI
import UIKit

struct Start: View {
    
    @State private var showMenu = false
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7
    
    var body: some View {
        
        ZStack {
            NavigationView{
                ZStack {
                    
                    LinearGradient(colors: [Color(0x9600ff), Color(0xAEBA)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    //-------------------------------------------------------
                    
                    
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
                    
                    
                }
            }
            
            HStack {
                Button {
                    print("but swipe")
                } label: {
                    Image(systemName: "x.circle.fill")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(Color(0xeb1c1c))
                        .shadow(radius: 2.5)
                        .padding()
                }
                
                VStack {
                    Button {
                        print("but swipe")
                    } label: {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(Color.white)
                            .shadow(radius: 2.5)
                    }
                    
                    Button {
                        print("but swipe")
                    } label: {
                        Image(systemName: "arrow.uturn.left.circle.fill")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(Color.white)
                            .shadow(radius: 2.5)
                    }
                }
                Button {
                    print("but swipe")
                } label: {
                    Image(systemName: "heart.circle.fill")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(Color.green)
                        .shadow(radius: 2.5)
                        .padding()
                }
                

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
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

struct Previews_Start_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
