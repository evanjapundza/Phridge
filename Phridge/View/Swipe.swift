//
//  Swipe.swift
//  Phridge
//
//  Created by Evan Japundza on 1/18/23.
//

import SwiftUI

struct Swipe: View {
    @ObservedObject var startData: RecipeSearchViewModel
    var user: Recipe
    
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    @State private var image: UIImage?
    
    var body: some View {
        
        
        GeometryReader{proxy in
            let size = proxy.size
            
            let index = CGFloat(startData.getIndex(user: user))
            let topOffset = (index <= 2 ? index : 2) * 15
            ZStack() {
                
                Color.gray
                    .frame(width: size.width-topOffset, height: size.height)
                    .cornerRadius(10)
                    .offset(y: -topOffset)
                
                
                Image(uiImage: image ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width-topOffset, height: size.height)
                    .cornerRadius(10)
                    .offset(y: -topOffset)
                    .onAppear(perform: loadImage)
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "info.square.fill")
                        }
                    }
                    
                    Spacer()
                    Text(user.title)
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    //Text("\(user.id)")
                        //.foregroundColor(Color.white)
                        //.font(.title)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 8)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
        .gesture(
            DragGesture()
                .updating($isDragging, body: {value, out, _ in out = true
                })
                .onChanged({ value in
                    
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                })
                .onEnded({ value in
                    
                    let width = getRect().width - 50
                    let translation = value.translation.width
                    
                    let checkingStatus = (translation > 0 ? translation : -translation)
                    
                    withAnimation {
                        if checkingStatus > (width / 2) {
                            offset = (translation > 0 ? width : -width) * 2
                            endSwipeActions()
                            
                            if translation > 0 {
                                rightSwipe(currentRecipe: user)
                            }
                            else {
                                leftSwipe(currentRecipe: user)
                            }
                        }
                        else {
                            offset = .zero
                        }
                    }
                })
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("BUTTONACTION"), object: nil)) {
            data in
            
            guard let info = data.userInfo else {
                return
            }
            
            let id = info["id"] as? String ?? ""
            let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = getRect().width - 50
            
            if String(user.id) == id{
                
                withAnimation{
                    offset = (rightSwipe ? width : -width) * 2
                    endSwipeActions()
                    
                    if rightSwipe {
                        self.rightSwipe(currentRecipe: user)
                    }
                    else {
                        leftSwipe(currentRecipe: user)
                    }
                }
            }
        }
    }
    
    func getRotation(angle: Double)->Double {
        
        let rotation = (offset / (getRect().width - 50)) * angle
        
        return rotation
    }
    
    func endSwipeActions() {
        withAnimation(.none){
            endSwipe = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            if let _ = startData.fetched_users.first {
                
                let _ = withAnimation {
                    startData.fetched_users.removeFirst()
                }
            }
        }
    }
    
    func leftSwipe(currentRecipe: Recipe) {
        
    }
    
    func rightSwipe(currentRecipe: Recipe) {
        
    }
    
    func loadImage() {
        let url = URL(string: user.image)!
            URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }.resume()
        }
}

struct Swipe_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View{
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}
