//
//  OnBoarding.swift
import SwiftUI

struct OnBoarding: View {
    @State private var weight: String = ""
    @State private var isTextFieldEmpty: Bool = true
    @State private var showNextPage: Bool = false
    @State private var waterIntake: Double = 0
    @State private var cups: Int = 0
    
    private func calculateWaterIntake() {
        if let weightValue = Double(weight) {
            waterIntake = weightValue * 0.03
            cups = (Int)(waterIntake * 4.22675284)
        } else {
            waterIntake = 0.0
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                if showNextPage {
                    Text("This is the next onboarding page")
                        .padding()
                } else {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.init(top: 10, leading: 5, bottom: 5, trailing: 5))
                    Text("iHydrate")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("tittleFont"))
                        .padding(.bottom, 5)
                        .padding(.init(top: 10, leading: 10, bottom: 5, trailing: 3))
                    Text("Start with iHydrate to record and track your water intake daily based on your needs and stay hydrated")
                        .font(.body)
                        .foregroundColor(Color("textFont"))
                        .multilineTextAlignment(.leading)
                        .padding(.init(top: 10, leading: 10, bottom: 5, trailing: 3))
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(.lightGrey)
                            .cornerRadius(10)
                            .frame(width: 350, height: 50)
                        HStack{
                            Spacer()
                            Spacer()
                            Text("Body Weight")
                            TextField("weight", text: $weight)
                                .keyboardType(.decimalPad)
                                .onChange(of: weight) { newValue in
                                    calculateWaterIntake()
                                    isTextFieldEmpty = newValue.isEmpty
                                }
                            Text("Kg")
                                .padding(.horizontal, 40)
                        }
                    }.padding(10)
                    Spacer()
                    NavigationLink(destination: createNextPage(waterIntake: waterIntake)) {
                        Text("Calculate Now")
                            .padding(.init(top: 16, leading: 120, bottom: 16, trailing: 120))
                            .background(isTextFieldEmpty ? Color.darkGrey : Color.skyBlue)
                            .foregroundColor(Color.white)
                            .cornerRadius(12)
                    }
                    .frame(width: 358, height: 50)
                    .padding(.vertical)
                    .disabled(isTextFieldEmpty)
                }
            }
            .padding(17)
            .navigationBarHidden(true)
        }
    }
    
    private func createNextPage(waterIntake: Double) -> some View {
        return AnyView(
            VStack(alignment: .leading, spacing: 5) {
                Text("The needed water intake")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("tittleFont"))
                    .padding(.bottom, 5)
                    .padding(.top, 100)
                    .padding(.leading, 10)
                Text("Your body needs \(waterIntake, specifier: "%.1f") liters of hydration, which is equivalent to \(Int(waterIntake * 4.22675284)) cups")
                    .font(.body)
                    .foregroundColor(Color("textFont"))
                    .multilineTextAlignment(.leading)
                    .padding(.init(top: 10, leading: 10, bottom: 5, trailing: 3))
                
                HStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.lightGrey)
                            .cornerRadius(10)
                            .frame(width: 171, height: 159)
                        
                        Image("cups")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 42, height: 61)
                        Text("\(cups)")
                            .padding(.top, 100)
                            .padding(.leading, -20)
                        Text("Cups")
                            .font(.caption)
                            .foregroundColor(.textFont)
                            .padding(.top, 100)
                            .padding(.leading, 23)
                    }
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.lightGrey)
                            .cornerRadius(10)
                            .frame(width: 171, height: 159)
                        
                        Image("liter")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 42, height: 61)
                        Text("\(waterIntake, specifier: "%.1f")")
                            .padding(.top, 100)
                            .padding(.leading, -20)
                        Text("L")
                            .font(.caption)
                            .foregroundColor(.textFont)
                            .padding(.top, 100)
                            .padding(.leading, 20)
                    }
                }
                
                Spacer()
                NavigationLink(destination: ThirdOnboardingView(waterIntake: waterIntake)) {
                    Text("Set Notifications")
                        .padding()
                        .frame(width: 358, height: 50)
                        .background(Color.skyBlue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.vertical)
                }
            }
        )
    }
    
    // Function to create the next onboarding page
    private func ThirdOnboardingView(waterIntake: Double) -> some View {
        let buttonTitles = ["15", "30", "60", "90", "2", "3", "4", "5"]
        
        return AnyView(
            VStack {
                Text("Notification Preferences")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("tittleFont"))
                    .padding(.bottom, 5)
                Text("The start and End hour")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("tittleFont"))
                    .padding(.bottom, 5)
                    .padding(.top, 100)
                    .padding(.leading, 10)
                Text("Specify the start and end date to receive the notifications ")
                    .font(.body)
                    .foregroundColor(Color("textFont"))
                    .multilineTextAlignment(.leading)
                    .padding(.init(top: 10, leading: 10, bottom: 5, trailing: 3))
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.lightGrey)
                            .cornerRadius(10)
                            .frame(width: 350, height: 50)
                        
                        HStack {
                            Text("start hour")
                                .padding(.horizontal, 40)
                            TextField("00:00 AM", text: .constant(""))
                        }
                    }
                    
                    ZStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                            .frame(width: 330)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 350, height: 50)
                    } .offset(y: -25)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.lightGrey)
                            .cornerRadius(10)
                            .frame(width: 350, height: 50)
                        
                        HStack {
                            Text("end hour")
                                .padding(.horizontal, 40)
                            TextField("00:00 PM", text: .constant(""))
                        }
                    }.offset(y: -50)
                }
                Text("Notification interval")
                    .fontWeight(.bold)
                    .foregroundColor(Color("tittleFont"))
                    .multilineTextAlignment(.leading)
                Text("How often would you like to receive notifications within the specified time interval ")
                    .font(.body)
                    .foregroundColor(Color("textFont"))
                    .multilineTextAlignment(.leading)
                ScrollView {
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            ForEach(buttonTitles[0..<4], id: \.self) { title in
                                Button(action: {
                                    // Action to perform when the button is tapped
                                }) {
                                    VStack {
                                        Text(title)
                                            .foregroundColor(.skyBlue)
                                            .font(.headline.bold())
                                        Text("Mins")
                                            .foregroundColor(.tittleFont)
                                            .font(.subheadline)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.lightGrey)
                                    .cornerRadius(8)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        HStack(spacing: 16) {
                            ForEach(buttonTitles[4..<8], id: \.self) { title in
                                Button(action: {
                                    // Action to perform when the button is tapped
                                }) {
                                    VStack {
                                        Text(title)
                                            .foregroundColor(.skyBlue)
                                            .font(.headline.bold())
                                        Text("Hours")
                                            .foregroundColor(.tittleFont)
                                            .font(.subheadline)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.lightGrey)
                                    .cornerRadius(8)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                
                NavigationLink(destination: LiterView(literNeed: waterIntake, cupSend: cups)) {
                    Text("Start")
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.skyBlue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.top, 20)
                }
                .padding() // Add padding to the entire VStack
            }
        )
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
