//
//  OnBoarding.swift
import SwiftUI
import WatchConnectivity


struct OnBoarding: View {
    
    let sessionDelegate = SessionDelegate()
    
    @State  var weight: String = ""
    @State  var isTextFieldEmpty: Bool = true
    @State  var showNextPage: Bool = false
    @State  var waterIntake: Double = 0
    @State  var cups: Int = 0
    
    
    @State  var startHour: String = ""
    @State  var endHour: String = ""
    @State  var selectedButton: String?
    @State  var selectedButtonIndex: Int?
    
    
    func calculateWaterIntake() {
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
//                            .onTapGesture {
//                                sendToWatch()
//                            }
                    }
                    .frame(width: 358, height: 50)
                    .padding(.vertical)
                    .disabled(isTextFieldEmpty)
                }
            }
            .padding(17)
            .navigationBarHidden(true)
        }.onAppear {
            if WCSession.isSupported() {
                let session = WCSession.default
                session.delegate = sessionDelegate
                session.activate()
            }
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
                }.navigationBarBackButtonHidden()
            }.padding()
        )
    }
    
    // Function to create the next onboarding page
    private func ThirdOnboardingView(waterIntake: Double) -> some View {
        let buttonTitles = ["15", "30", "60", "90", "2", "3", "4", "5"]
        
        return AnyView(
            VStack(spacing: 10) {
                Text("Notification Preferences")
                // .font(.title2)
                
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(Color("tittleFont"))
                    .padding(.bottom, 5)
                    .padding(.top, -10)
                    .frame(maxWidth: .infinity, alignment: .leading) // Aligning to the left
                    .padding(.leading, 14) // Padding for indentation
                Spacer()
                Spacer()
                VStack(spacing: 10) {
                    Text("The start and End hour")
                        .font(.headline)
                        .font(.system(size: 17))
                    // .fontWeight(.bold)
                        .foregroundColor(Color("tittleFont"))
                        .padding(.bottom, -10)
                        .frame(maxWidth: .infinity, alignment: .leading) // Aligning to the left
                        .padding(.leading, 14) // Padding for indentation
                    Text("Specify the start and end date to receive the notifications ")
                    // .font(.body)
                        .foregroundColor(Color("textFont"))
                        .font(.system(size: 13))
                        .frame(maxWidth: .infinity, alignment: .leading) // Aligning to the left
                        .padding(.leading, 14) // Padding for indentation
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Spacer().frame(height: 30)
                    ZStack {
                        Rectangle()
                            .foregroundColor(.lightGrey)
                            .cornerRadius(10)
                            .frame(width: 350, height: 100)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Start hour")
                                Spacer().frame(height: 10);                Text("End hour")
                            }
                            .padding(.horizontal, 40)
                            
                            VStack {
                                TextField("00:00 AM", text: .constant(""))
                                TextField("00:00 PM", text: .constant(""))
                            }
                        }
                        
                        ZStack {
                            Spacer().frame(height: 120)
                            Rectangle()
                                .frame(height: 0.4)
                                .foregroundColor(.gray)
                                .frame(width: 320)
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 60, height: 1) // Adjust the height to make it thinner
                            //                                .alignmentGuide(.leading) { _ in
                            //                                    100 // Half of the rectangle's width to align it to the left
                            
                        }
                        
                        //                    ZStack {
                        //                        Rectangle()
                        //                            .foregroundColor(.lightGrey)
                        //                            .cornerRadius(10)
                        //                            .frame(width: 350, height: 50)
                        //
                        //                        HStack {
                        //                            Text("end hour")
                        //                                .padding(.horizontal, 40)
                        //                            TextField("00:00 PM", text: .constant(""))
                        //                        }
                    }.offset(y: -60)
                }
                .padding(-17)
                
                Text("Notification interval")
                    .font(.headline)
                    .font(.system(size: 17))
                //.fontWeight(.bold)
                    .foregroundColor(Color("tittleFont"))
                    .frame(maxWidth: .infinity, alignment: .leading) // Aligning to the left
                    .padding(.leading, 14) // Padding for indentation
                Text("How often would you like to receive notifications within the specified time interval ")
                // .font(.body)
                    .font(.system(size: 13))
                    .foregroundColor(Color("textFont"))
                    .padding(.leading, 14)
                    .multilineTextAlignment(.leading)
                ScrollView {
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            ForEach(buttonTitles[0..<4], id: \.self) { title in
                                Button(action: {
                                    // Action to perform when the button is tapped
                                    selectedButtonIndex = buttonTitles.firstIndex(of: title)
                                }) {
                                    VStack {
                                        Text(title)
                                            .foregroundColor(selectedButtonIndex == buttonTitles.firstIndex(of: title) ? .white : .skyBlue)
                                        
                                        
                                            .font(.system(size: 22))
                                            .fontWeight(.bold)
                                        
                                        
                                        Text("Mins")
                                            .foregroundColor(selectedButtonIndex == buttonTitles.firstIndex(of: title) ? .white : .black)
                                            .font(.system(size: 13))
                                            .font(.subheadline)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(selectedButtonIndex == buttonTitles.firstIndex(of: title) ? Color.skyBlue : Color.lightGrey)
                                            .cornerRadius(8)
                                    )  }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        HStack(spacing: 16) {
                            ForEach(buttonTitles[4..<8], id: \.self) { title in
                                Button(action: {
                                    // Action to perform when the button is tapped
                                    selectedButtonIndex = buttonTitles.firstIndex(of: title)
                                }) {
                                    VStack {
                                        Text(title)
                                            .foregroundColor(selectedButtonIndex == buttonTitles.firstIndex(of: title) ? .white : .skyBlue)
                                            .font(.system(size: 22))
                                            .fontWeight(.bold)
                                        Text("Hours")
                                            .foregroundColor(selectedButtonIndex == buttonTitles.firstIndex(of: title) ? .white : .black)
                                        //  .foregroundColor(.tittleFont)
                                            .font(.system(size: 13))
                                            .font(.subheadline)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(selectedButtonIndex == buttonTitles.firstIndex(of: title) ? Color.skyBlue : Color.lightGrey)
                                    ) }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }/*.frame(maxWidth: .infinity, alignment: .center)*/
                        .padding()
                }
                
                NavigationLink(destination: LiterView(literNeed: waterIntake, cupSend: cups)) {
                    Text("Start")
                        .padding()
                        .frame(width: 358, height: 50)
                        .background(startHour.isEmpty || endHour.isEmpty || selectedButton == nil ? Color.skyBlue : Color.skyBlue)
                        .background(Color.skyBlue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.top, 20)
                }
                .padding() // Add padding to the entire VStack
            }.padding()
                .padding(.top, 50)
                .navigationBarBackButtonHidden()
        )
    }
    
    
    
    
    
    func scheduleNotifications() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error requesting authorization: \(error)")
                return
            }
            
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "Hydration Reminder"
                content.body = "To help you stay reminded to drink water, iHydrate will notify you just in time"
                content.sound = UNNotificationSound.default
                
                if let startDate = dateFromString(startHour), let endDate = dateFromString(endHour), let interval = selectedButton {
                    let trigger = UNCalendarNotificationTrigger(dateMatching: componentsForDate(startDate), repeats: true)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    center.add(request) { error in
                        if let error = error {
                            print("Error scheduling notification: \(error)")
                        } else {
                            print("Notification scheduled successfully!")
                        }
                    }
                }
            } else {
                print("Notification authorization denied")
            }
        }
    }
    
    func dateFromString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.date(from: dateString)
    }
    
    func componentsForDate(_ date: Date) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        return components
    }
    
}


//func sendToWatch() {
//        if WCSession.default.isReachable {
//            let message = ["waterIntake": waterIntake , "cups": cups] as [String : Any]
//            WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: { error in
//                print("Error sending message to watch: \(error.localizedDescription)")
//            })
//        } else {
//            print("Watch is not reachable. test")
//
//        }
//    }
//
//
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//
//       }




struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}


