//
//  CupsView.swift
//  Hydrate
//
//  Created by Maryam Mohammad on 03/08/1445 AH.
//

import SwiftUI

struct CupsView: View {
    @Binding var cups: Int
    @State var cupsDrink = 0
    
    @State private var isImage1Visible = Array(repeating: true, count: 20)
    
    var body: some View {
        VStack {
            VStack(alignment: .leading , spacing: 17) {
                Text("Today's Water Intake")
                    .font(.system(size: 16))
                    .foregroundColor(.textFont)
                
                Text("\(cupsDrink) cups / \(cups) cups")
                    .font(.system(size: 28))
                    .foregroundColor(.tittleFont).bold()
            }.padding(.top , 60)
             .padding(.leading , -150)
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 4), spacing: 10) {
                    ForEach(0..<cups, id: \.self) { index in
                        Button(action: {
                            if isImage1Visible[index] {
                                isImage1Visible[index].toggle()
                                cupsDrink += 1
                            } else {
                                isImage1Visible[index].toggle()
                                cupsDrink -= 1
                            }
                        }) {
                            if isImage1Visible[index] {
                                Image("waterEmpty")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                            } else {
                                Image("waterFull")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
            }.padding(.top , 60)
        }
    }
}




    

#Preview {
    CupsView(cups: .constant(20))
}


//struct CupsView: View {
//    @State var cupsNeed = 20
//    @State var cupsDrink = 0
//    
//    @State private var isImage1Visible = Array(repeating: true, count: 20)
//    
//    var body: some View {
//        VStack {
//            VStack(alignment: .leading , spacing: 17) {
//                Text("Today's Water Intake")
//                    .font(.system(size: 16))
//                    .foregroundColor(.textFont)
//                
//                Text("\(cupsDrink) cups / \(cupsNeed) cups")
//                    .font(.system(size: 28))
//                    .foregroundColor(.tittleFont).bold()
//            }.padding(.top , 60)
//             .padding(.leading , -150)
//            
//            ScrollView {
//                LazyVGrid(columns: Array(repeating: GridItem(), count: 4), spacing: 10) {
//                    ForEach(0..<cupsNeed, id: \.self) { index in
//                        Button(action: {
//                            isImage1Visible[index].toggle()
//                            cupsDrink = cupsDrink + 1
//                        }) {
//                            if isImage1Visible[index] {
//                                Image("waterEmpty")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 80, height: 80)
//                                    .clipShape(Circle())
//                            } else {
//                                Image("waterFull")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 80, height: 80)
//                                    .clipShape(Circle())
//                            }
//                        }
//                    }
//                }
//            }.padding(.top , 60)
//        }
//    }
//}
