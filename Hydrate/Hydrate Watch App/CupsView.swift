//
//  CupsView.swift
//  Hydrate Watch App
//
//  Created by Maryam Mohammad on 03/08/1445 AH.
//

import SwiftUI

struct CupsView: View {
     var cupsNeed: Int = 20
    @State var cupsDrink = 0
    
    @State private var isImage1Visible = Array(repeating: true, count: 20)
    
    var body: some View {
        VStack {

                
                Text("\(cupsDrink) cups / \(cupsNeed) cups")
                    .font(.system(size: 18))
                    .foregroundColor(.tittleFont).bold()
                    .padding(.top , -25)
                    .padding(.leading , -20)

            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 1), spacing: 10) {
                    ForEach(0..<cupsNeed, id: \.self) { index in
                        Button(action: {
                            if isImage1Visible[index] {
                                isImage1Visible[index].toggle()
                                cupsDrink += 1
                            } else {
                                isImage1Visible[index].toggle()
                                cupsDrink -= 1
                            }
                        })
                        {
                            if isImage1Visible[index] {
                                Image("waterEmpty")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    
                            } else {
                                Image("waterFull")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    
                            }
                        }.buttonStyle(.plain)
                    }

                }
            }.scrollIndicators(.hidden)
        }
    }
}


#Preview {
    CupsView()
}
