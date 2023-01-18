//
//  Splash.swift
//  TheLight
//
//  Created by Khulood Alhamed on 12/01/2023.
//

import SwiftUI

let backgroundGradient = LinearGradient(
    colors: [Color(red: 94 / 255, green: 126 / 255, blue: 152 / 255),Color(red: 131 / 255, green: 180 / 255, blue: 165 / 255)],
    
    startPoint: .top, endPoint: .bottom)

struct Splash: View {
    @State var isActive:Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State var currentTimeA = Date()
    @State var isNight = true

    var body: some View {
        
        
        if isActive {
            Main()
            
        }
        else{
            ZStack{
                
                Image(isNight ? "nightBackground" : "morningBackground")
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack{
                    
                    
                    Image("logoYellowShadow")
                    
                    
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size=0.9
                        self.opacity=1.0
                    }
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline:.now()+2.0 )
                    {
                        self.isActive=true
                    }
                }
            }.onAppear{
                checkTime ()
            }
            
            
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



//struct Morning_background: View{
//    @State var currentTimeA = Date()
//    @State var isNight = true
//    //Backgroung Img:
//    var body: some View{
//      Text("")
//    }
    
//}
struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}

