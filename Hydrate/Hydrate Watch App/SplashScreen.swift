//
//  SplashScreen.swift
//  Hydrate Watch App
//
//  Created by Maryam Mohammad on 03/08/1445 AH.
//

import SwiftUI

struct SplashScreen: View {
@State var isActive = false
@State var size = 0.8
@State var opacity = 0.5

var body: some View {
    
    if isActive{
        LiterView()
    } else {
        ZStack{
            Image("Logo")
                .resizable()
                .frame(width: 96 , height: 84)
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear { withAnimation(.easeIn(duration: 2.0)){
                    self.size = 0.9
                    self.opacity = 1.9
                }
                }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                self.isActive = true
            }
        }
        
    }
    
}
}

#Preview {
SplashScreen()
}
