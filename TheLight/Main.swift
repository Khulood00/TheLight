//
//  Main.swift
//  TheLight
//
//  Created by Khulood Alhamed on 08/01/2023.
//
import SwiftUI
// Local notification
import UserNotifications
import Accessibility
class NotificationManager{
    static let instance = NotificationManager()
    
    func scheduleNotification(hour: Int,minute: Int){
        
        let center = UNUserNotificationCenter.current()
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { (success, error)in
            guard error != nil else { return }
        }
        let content = UNMutableNotificationContent()
        content.title = "Flexy"
        content.subtitle = "It's your stretching time!"
        content.sound = .default
        content.badge = 0
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
// Local notification end
struct Main: View {
    @State var currentTimeA = Date()
    @State var isNight = true
    var body: some View {
        
        NavigationView{
            ZStack(alignment: .top){
              Image(isNight ? "nightBackground" : "morningBackground")
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack(alignment: .center, spacing: 10){
                    
                    DisclosureGroup{
                        VStack{
                            HStack{
                                Image(systemName: "sun.max.fill")
                                    .accessibilityHidden(true)
                                Text("Morning")
                                    .modifier(notificationText())
                                DatePicker("", selection: $currentTimeA,displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .accentColor(.blue)
                                    .accessibilityLabel("Morning")
                                    .accessibilityHint("Chose the reminder time")
                            }
                            HStack{
                                Image(systemName: "moon.fill")
                                    .accessibilityHidden(true)
                                Text("Evning   ")
                                    .modifier(notificationText())
                                
                                DatePicker("", selection: $currentTimeA,displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .accentColor(.blue)
                                    .accessibilityLabel("Evning")
                                    .accessibilityHint("Chose the reminder time")
                            }
                            Button("Schedule Notification"){
                                let components = Calendar.current.dateComponents([.hour , .minute], from: currentTimeA)
                                
                                // print(selectedDate)
                                let hours = components.hour ?? 0
                                let minute = components.minute ?? 0
                                // print(hours)
                                // print(minute)
                                
                                NotificationManager.instance.scheduleNotification(hour: hours, minute: minute)
                                
                            }.buttonStyle(.bordered)
                                
                            
                                .accessibilityLabel("Schedule Notification")
                              
                            
                        }.padding(.top, 20)
                    }
                label: {
                    VStack{
                        HStack{
                            Text("Schedule time to exercise")
                                .modifier(notificationText())
                            
                                .accessibilityLabel("Schedule time to exercise")
                        }
                    }
                }
                .onAppear{
                    UIApplication.shared.applicationIconBadgeNumber = 0
                }
                }.accentColor(.black)
                    .font(.title3)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                    .padding(.top)
                    .padding(.bottom)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    .padding(.bottom, 550)
                    .padding(.leading, 20)
                    .padding(.trailing,20)
                    .padding(.top, 100)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                VStack{
                    Omnya()
                }
                // .padding(.top, 300)
            }
        }.onAppear{
            checkTime ()
        }
    }
    func checkTime ()
    {
        self.currentTimeA = Date()
        self.isNight = isNight
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        let dateString = formatter.string(from: Date())
        print("the time now is \(dateString)")
        
        if dateString == "AM"
        {
            self.isNight = false

        }
        else
        {
            self.isNight = true
        }
    }
}
struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
