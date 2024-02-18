//
//  LiterView.swift
//  Hydrate
//
//  Created by Maryam Mohammad on 03/08/1445 AH.
//

import SwiftUI

struct LiterView: View {
    
    @Binding var waterIntake: Double
    @State var literDrink = 0.0
    
    @State var cupsNeed = 20
    @State var cupsDrink = 0
    
    @State private var isAnimating = false
    
     var emoji: String {
            let emojiProgress = literDrink / waterIntake

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
        TabView{
            
            VStack{
                VStack(alignment: .leading , spacing: 17){
                    Text("Today's Water Intake")
                        .font(.system(size: 16))
                        .foregroundColor(.textFont)
                    
                    Text("\(literDrink, specifier: "%.1f") liter / \(waterIntake, specifier: "%.1f") liter")
                        .font(.system(size: 28))
                        .foregroundColor(.tittleFont).bold()
                }.padding(.bottom , 90)
//                }.padding(.top , -150)
                .padding(.leading , -150)
                
                ZStack{
                    
                    Circle()
                        .stroke(lineWidth: 40)
                        .frame(width: 300 , height: 300)
                        .foregroundColor(.lightSkyBlue)

                        Circle()
                            .trim(from: 0.0 , to: CGFloat(literDrink / waterIntake))
                            .stroke(style: StrokeStyle(lineWidth: 40, lineCap: .round) )
                            .frame(width: 300 , height: 300)
                            .rotationEffect(.degrees(-90))
                            .foregroundStyle(LinearGradient(gradient: Gradient( colors:[.skyBlue]), startPoint: .topLeading , endPoint: .bottomTrailing))
                            .animation(.linear(duration: 0.3)) // Animate the progress

                    
                    
                                    
                            let emojiAngle = 360 * (literDrink / waterIntake) - 90
                            let emojiOffsetX = 150 * cos(emojiAngle * .pi / 180)
                            let emojiOffsetY = 150 * sin(emojiAngle * .pi / 180)

                                    
                    Text(emoji)
                               .font(.system(size: 40))
                               .offset(x: emojiOffsetX , y: emojiOffsetY)
                               .animation(.linear(duration: 0.3))
                           
                        
                    
                }.padding(.bottom , 90)
                
                HStack{
                    Spacer()
                    Button{
                        if literDrink > 0.0 {
                            literDrink -= 0.1
                            if literDrink < 0.0 {
                                literDrink = 0.0
                            }
                        }

                    } label: {
                        ZStack{
                            Rectangle()
                                .foregroundColor(.lightGrey)
                                .cornerRadius(100)
                                .frame(width: 50 , height: 50)
                            
                            Image(systemName: "minus")
                                .padding(10)
                                .foregroundColor(literDrink <= 0.0 ? .darkGrey : .skyBlue).bold()
                                
                        }
                    }.disabled(literDrink <= 0.0)
                    Spacer()
                    Text("\(literDrink, specifier: "%.1f")")
                        .font(.system(size: 34)).bold()
                    Spacer()
                    Button{
                        if literDrink < waterIntake {
                            literDrink += 0.1
                            }

                    } label: {
                        
                        ZStack{
                            Rectangle()
                                .foregroundColor(.lightGrey)
                                .cornerRadius(100)
                                .frame(width: 50 , height: 50)
                            
                            Image(systemName: "plus")
                                .padding(10)
                                .foregroundColor(literDrink >= waterIntake ? .darkGrey : .skyBlue).bold()
                               
                        }
                        
                    }.disabled(literDrink >= waterIntake)
                    
                    Spacer()
                }
                
            }
            
            
////////////////////// SECOND VIEW ///////////////////////////
            
            
            
            
           CupsView()
            
            
            
            
            
            
            
            
            
        }.tabViewStyle(PageTabViewStyle())
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .overlay(
                VStack {
                    Spacer()
                    PageControl(numberOfPages: 2, currentPage: 0, pageIndicatorTintColor: .lightGrey, currentPageIndicatorTintColor: .skyBlue)
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
    LiterView(waterIntake: .constant(2.1))
}
