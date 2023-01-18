//
//  AllModifiers.swift
//  TheLight
//
//  Created by Omnya Kamal  on 09/01/2023.
//

import SwiftUI
struct TheEndTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
      //.bold()
            .font(.system(size: 28))
            .foregroundColor(.black)
            .frame(width: 300.0)
            .transition(.scale)
    }
}
struct notificationText: ViewModifier {
    func body(content: Content) -> some View {
        content
      //.bold()
            .font(.system(size: 22))
            .foregroundColor(.black)
           // .frame(width: 300.0)
           // .transition(.scale)
    }
}
struct TimerModifier: ViewModifier {
    @State var currentTimeA = Date()
    @State var isNight = true
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50 , weight: .bold))
            .foregroundColor(isNight ? Color.white : Color.black)
            .padding(.top, 400.0)
            .transition(.scale)
            .onAppear{
                checkTime()
          
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

struct StartTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
      //      .bold()
            .font(.system(size: 28))
            .foregroundColor(.black)
            .frame(width: 200.0, height: 200.0)
    }
}


struct AllModifiers: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AllModifiers_Previews: PreviewProvider {
    static var previews: some View {
        AllModifiers()
    }
}

