//
//  LiterView.swift
//  Hydrate
//
//  Created by Maryam Mohammad on 03/08/1445 AH.
//

import SwiftUI

struct LiterView: View {
    @State private var selectedTabIndex = 0
    
    var literNeed: Double
    @State var literDrink = 0.0
    
//    var cupsNeed: Int
    @State var cupsDrink = 0
    var cupSend: Int 
    @State private var isAnimating = false
    
     var emoji: String {
            let emojiProgress = literDrink / literNeed

            switch emojiProgress {
            case 0..<0.25:
                return "😴"
            case 0.25..<0.50:
                return "😃"
            case 0.50..<0.75:
                return "😁"
            case 0.75..<1:
                return "😍"
            default:
                return "🥳"
                   
            }
                
        }
    
    
    var body: some View {
        TabView(selection: $selectedTabIndex){
            
            VStack{
                VStack(alignment: .leading , spacing: 17){
                    Text("Today's Water Intake")
                        .font(.system(size: 16))
                        .foregroundColor(.textFont)
                    
                    Text("\(literDrink, specifier: "%.1f") liter / \(literNeed, specifier: "%.1f") liter")
                        .font(.system(size: 28))
                        .foregroundColor(.tittleFont).bold()
                }.padding(.bottom , 90)
//                }.padding(.top , -150)
                .padding(.leading , -150)
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 40)
                        .frame(width: 300 , height: 300)
                        .foregroundColor(.lightSkyBlue)

                    Circle()
                        .trim(from: 0.0 , to: CGFloat(literDrink / literNeed))
                        .stroke(style: StrokeStyle(lineWidth: 40, lineCap: .round))
                        .frame(width: 300 , height: 300)
                        .rotationEffect(.degrees(-90))
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors:[.skyBlue]), startPoint: .topLeading , endPoint: .bottomTrailing))
                        .animation(.linear(duration: 0.3)) // Animate the progress

                    let emojiAngle = 360 * (literDrink / literNeed) - 90
                    let emojiOffsetX = 150 * cos(emojiAngle * .pi / 180)
                    let emojiOffsetY = 150 * sin(emojiAngle * .pi / 180)

                    Text(emoji)
                        .font(.system(size: 40))
                        .offset(x: emoji == "🥳" ? 0 : emojiOffsetX, y: emoji == "🥳" ? 0 : emojiOffsetY)
                        .animation(.linear(duration: 0.3))
                }
                .padding(.bottom , 90)
                
               
                        VStack {
                            HStack {
                                Spacer()
                                Button {
                                    if literDrink > 0.0 {
                                        literDrink -= 0.1
                                        if literDrink < 0.0 {
                                            literDrink = 0.0
                                        }
                                    }
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(.lightGrey)
                                            .cornerRadius(100)
                                            .frame(width: 50, height: 50)

                                        Image(systemName: "minus")
                                            .padding(10)
                                            .foregroundColor(literDrink <= 0.0 ? .darkGrey : .skyBlue).bold()
                                    }
                                }.disabled(literDrink <= 0.0)
                                Spacer()
                                
                                // TextField for manual input
                                TextField("Enter value", text: Binding<String>(
                                    get: {  String(format: "%.1f", literDrink) },
                                    set: {
                                        if let value = Double($0) {
                                            literDrink = value
                                        }
                                    }
                                ))
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                                .font(.system(size: 34)).bold()
                                .multilineTextAlignment(.center)
                                
                                Spacer()
                                
                                Button {
                                    if literDrink < literNeed {
                                        literDrink += 0.1
                                    }
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(.lightGrey)
                                            .cornerRadius(100)
                                            .frame(width: 50, height: 50)

                                        Image(systemName: "plus")
                                            .padding(10)
                                            .foregroundColor(literDrink >= literNeed ? .darkGrey : .skyBlue).bold()
                                    }
                                }.disabled(literDrink >= literNeed)
                                Spacer()
                            }
                            .padding()
                        }
                

                
            }.tag(0)
            
            
////////////////////// SECOND VIEW ///////////////////////////
            
            
            
            
            CupsView(cupsNeed: cupSend)
                .tag(1)
            
            
            
            
            
            
            
            
            
        }.tabViewStyle(PageTabViewStyle())
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .overlay(
                VStack {
                    Spacer()
                    PageControl(numberOfPages: 2, currentPage: selectedTabIndex, pageIndicatorTintColor: selectedTabIndex == 0 ? .lightGrey : .skyBlue, currentPageIndicatorTintColor: selectedTabIndex == 0 ? .skyBlue : .lightGrey)
                        .padding(.bottom, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color.clear)
                }
                .edgesIgnoringSafeArea(.bottom)
            )
        Text("Swipe right for cups calculating")
            .font(.system(size: 11))
            .foregroundColor(.textFont)
                
        //
    }
}

#Preview {
    LiterView(literNeed: 2.1, cupSend: 10)
}



