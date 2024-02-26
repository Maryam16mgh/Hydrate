//
//  LiterView.swift
//  Hydrate Watch App
//
//  Created by Maryam Mohammad on 03/08/1445 AH.
//

import SwiftUI
import WatchConnectivity

class SessionDelegate: NSObject, WCSessionDelegate {
    var waterIntake: Double = 0
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Test connection")
        if let receivedWaterIntake = message["waterIntake"] as? Double {
            DispatchQueue.main.async {
                self.waterIntake = receivedWaterIntake
            }
        } else {
            print("Failed to receive water intake")
        }
    }
}





struct LiterView: View {

    
    @State var literDrink = 0.0
       @State private var isAnimating = false
       @State private var sessionDelegate = SessionDelegate()
    
   
    
     var emoji: String {
         let emojiProgress = literDrink / sessionDelegate.waterIntake

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
                
                ZStack {
                    VStack{
                        Text("\(literDrink , specifier: "%.1f")")
                            .font(.system(size: 25))
                            .foregroundColor(.tittleFont).bold()
                        Text("\(sessionDelegate.waterIntake, specifier: "%.1f") liter")
                            .font(.system(size: 15))
                            .foregroundColor(.textFont)
                    }.opacity(emoji == "🥳" ? 0 : 1)
                    
                    Circle()
                        .stroke(lineWidth: 30)
                        .frame(width: 117 , height: 117)
                        .foregroundColor(.lightSkyBlue)
                    
                    Circle()
                        .trim(from: 0.0 , to: CGFloat(literDrink / sessionDelegate.waterIntake))
                        .stroke(style: StrokeStyle(lineWidth: 30, lineCap: .round))
                        .frame(width: 117 , height: 117)
                        .rotationEffect(.degrees(-90))
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors:[.skyBlue]), startPoint: .topLeading , endPoint: .bottomTrailing))
                        .animation(.linear(duration: 0.3))
                    
                    let radius: CGFloat = 60
                    
                    let emojiAngle = 360 * (literDrink / sessionDelegate.waterIntake) - 90
                    let emojiOffsetX = radius * cos(emojiAngle * .pi / 180)
                    let emojiOffsetY = radius * sin(emojiAngle * .pi / 180)
                    
                    Text(emoji)
                        .font(.system(size: 27))
                        .offset(x: emoji == "🥳" ? 0 : emojiOffsetX, y: emoji == "🥳" ? 0 : emojiOffsetY)
                        .animation(.linear(duration: 0.3))
                }
                
                
                
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
                            .buttonStyle(.plain)
                        Spacer()
                        
                        TextField("Enter value", text: Binding<String>(
                            get: {  String(format: "%.1f", literDrink) },
                            set: {
                                if let value = Double($0) {
                                    literDrink = value
                                }
                            }
                        ))
                        .multilineTextAlignment(.center) 
                        .background(Color.clear)
                        .textFieldStyle(.plain)




                        
                        Spacer()
                        
                        Button {
                            if literDrink < sessionDelegate.waterIntake {
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
                                    .foregroundColor(literDrink >= sessionDelegate.waterIntake ? .darkGrey : .skyBlue).bold()
                            }
                        }.disabled(literDrink >= sessionDelegate.waterIntake)
                            .buttonStyle(.plain)
                        Spacer()
                    }
                   
                }
                
                
                
            }.tag(0)
            
            
            ////////////////////// SECOND VIEW ///////////////////////////
            
            
            
            
            CupsView()
                .tag(1)
            
            
            
            
            
            
        } .onAppear {
            if WCSession.isSupported() {
                let session = WCSession.default
                session.delegate = self.sessionDelegate
                session.activate()
            }
        }
       
                
        
    }
}





#Preview {
    LiterView()
}
