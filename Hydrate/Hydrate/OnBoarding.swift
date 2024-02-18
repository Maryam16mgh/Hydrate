//
//  OnBoarding.swift
import SwiftUI

struct OnBoarding: View {
    @State private var weight: String = ""// Define a state variable to hold the entered body weight
    @State public var startHour: String = ""
    @State public var endHour: String = ""
    @State private var isTextFieldEmpty: Bool = true // Track whether the TextField is empty or not
    @State private var showNextPage: Bool = false // Track whether to show the next onboarding page
    @State private var waterIntake: Double = 0 // Track the calculated water intake based on weight
    private func calculateWaterIntake() {
            if let weightValue = Double(weight) {
                waterIntake = weightValue * 0.03
            } else {
                waterIntake = 0.0
            }
        }
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) { // Align elements to the left and specify spacing
                if showNextPage {
                    // Show the next onboarding page
                    Text("This is the next onboarding page")
                        .padding()
                    // Add any other content for the next onboarding page here
                    // ...
                } else {
                    // Show the initial onboarding view
                    Image("Logo") // Assuming "Logo" is the name of your image asset
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100) // Adjust size as needed
                        .padding(.init(top: 10, leading: 5, bottom: 5, trailing: 5))
                    Text("iHydrate")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("tittleFont")) // Set font color
                        .padding(.bottom, 5) // Add some padding between title and body
                        .padding(.init(top: 10, leading: 10, bottom: 5, trailing: 3))
                    Text("Start with iHydrate to record and track your water intake daily based on your needs and stay hydrated")
                        .font(.body)
                        .foregroundColor(Color("textFont")) // Set font color
                        .multilineTextAlignment(.leading) // Align text to the left
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
                                    calculateWaterIntake() // Call the function here
                                    isTextFieldEmpty = newValue.isEmpty
                                }
                            Text("Kg")
                                .padding(.horizontal, 40)
                        }
                    }.padding(10)
                    Spacer()
                    NavigationLink(destination: self.createNextPage()) {
                        Text("Calculate Now") // Text inside the button
                            .padding(.init(top: 16, leading: 120, bottom: 16, trailing: 120)) // Add some padding around the text
                            .background(isTextFieldEmpty ? Color.darkGrey : Color.skyBlue) // Change the background color based on TextField
                            .foregroundColor(Color.white) // Text color of the button
                            .cornerRadius(12) // Corner radius of the button
                    }
                    .frame(width: 358, height: 50) // Fixed width and height
                    .padding(.vertical)
                    .disabled(isTextFieldEmpty) // Disable the button if the TextField is empty
                }
            }
            .padding(17) // Add padding around the VStack
            .navigationBarHidden(true)
        }
    }
    
   
    
    // Function to create the next onboarding page
    private func createNextPage() -> some View {
        return AnyView(
            VStack(alignment: .leading, spacing: 5) {
                
                Text("The needed water intake")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("tittleFont")) // Set font color
                    .padding(.bottom, 5) // Add some padding between title and body
                            .padding(.init(top: 100, leading: 10, bottom: 5, trailing: 3)) // Move the content down
                Text("Your body needs [specific number] liters of hydration, which is equivalent to [specific number] cups")
                    .font(.body)
                    .foregroundColor(Color("textFont")) // Set font color
                    .multilineTextAlignment(.leading) // Align text to the left
                            .padding(.init(top: 10, leading: 10, bottom: 5, trailing: 3))
                
                HStack {
                                    // First Rectangle with Image
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(.lightGrey)
                                            .cornerRadius(10)
                                            .frame(width: 171, height: 159)
                                        
                                        Image("cups")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 42, height: 61)
                                
                                        Text("\(waterIntake * 4.22675284, specifier: "%.1f")")
                                            .padding(.top, 100)
                                            .padding(.leading, -30)
                                        Text("Cups")
                                        .font(.caption)
                                        .foregroundColor(.textFont)
                                        .padding(.top, 100)
                                        .padding(.leading, 23)
                                    }
                                    
                                    // Second Rectangle with Image
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
                // Button to navigate to the third onboarding view
                   NavigationLink(destination: ThirdOnboardingView()) { // Replace ThirdOnboardingView with your actual third onboarding view
                       Text("Set Notifications") // Text inside the button
                           .padding(.init(top: 16, leading: 120, bottom: 16, trailing: 120)) // Add some padding around the text
                           .background(Color.skyBlue) // Background color of the button
                           .foregroundColor(Color.white) // Text color of the button
                           .cornerRadius(12) // Corner radius of the button
                           .frame(width: 358, height: 50) // Fixed width and height
                           .padding(.vertical)
                   }
               }
        )
    }
}
// Function to create the next onboarding page
 private func ThirdOnboardingView() -> some View {
    return AnyView(
        VStack {
            Text("Notification Preferences")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("tittleFont")) // Set font color
                .padding(.bottom, 5)
            Text("The start and End hour")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("tittleFont")) // Set font color
                .padding(.bottom, 5) // Add some padding between title and body
                        .padding(.init(top: 100, leading: 10, bottom: 5, trailing: 3)) // Move the content down
            Text("Specify the start and end date to receive the notifications ")
                .font(.body)
                .foregroundColor(Color("textFont")) // Set font color
                .multilineTextAlignment(.leading) // Align text to the left
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
                        .foregroundColor(.gray) // Separator
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
            
            
            
        }
    )
}
struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
