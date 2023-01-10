//
//  Main.swift
//  TheLight
//
//  Created by Khulood Alhamed on 08/01/2023.
//

import SwiftUI
import UserNotifications

struct Main: View {
    @State var currentTime = Date()
    @State var currentTime2 = Date()
    
    var body: some View {
        
        NavigationView{
            ZStack(alignment: .top){
                
                Image("nightBackground")
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack(alignment: .center, spacing: 10){
                    
                    DisclosureGroup{
                        VStack{
                            HStack{
                                Image(systemName: "sun.max.fill")
                                Text("Morning")
                                DatePicker("", selection: $currentTime,displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .accentColor(.blue)
                                
                            }
                            HStack{
                                Image(systemName: "moon.fill")
                                Text("Evning   ")
                                
                                DatePicker("", selection: $currentTime2,displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .accentColor(.blue)
                            }
                        }.padding(.top, 20)
                        
                    }
                label: {
                    VStack{
                        HStack{
                            
                            Text("Schedule time to exercise")
                            
                        }
                    }
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
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top, 100)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }
            
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}


