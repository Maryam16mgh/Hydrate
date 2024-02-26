//
//  CupsView.swift
//  Hydrate Watch App
//
//  Created by Maryam Mohammad on 03/08/1445 AH.
//

import SwiftUI
import WatchConnectivity




struct CupsView: View {
    @State var cups = 0
    @State var cupsDrink = 0
    
    @State private var isImage1Visible = Array(repeating: true, count: 20)
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let cups = message["cups"] as? Int {
            
            DispatchQueue.main.async {
               
                self.cups = cups
            }
        }
    }
    
    var body: some View {
        VStack {

                
                Text("\(cupsDrink) cups / \(cups) cups")
                    .font(.system(size: 18))
                    .foregroundColor(.tittleFont).bold()
                    .padding(.top , -25)
                    .padding(.leading , -20)

            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 1), spacing: 10) {
                    ForEach(0..<cups, id: \.self) { index in
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
        
        .onAppear {
                    if WCSession.isSupported() {
                        let session = WCSession.default
                        let sessionDelegate = SessionDelegate()
                        session.delegate = sessionDelegate
                        session.activate()
                    }
                }
    }
}


#Preview {
    CupsView()
}
