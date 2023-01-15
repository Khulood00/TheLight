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

    var body: some View {
        if isActive {
            Main()
        }
        else{
            ZStack{
                
            Morning_background()

                VStack{
                    
                    Image("Logo")
                        
                    
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
            }
        }
        
       
      
    }
}

struct Morning_background: View{
    //Backgroung Img:
    var body: some View{
        Image("morningBackground")
            .ignoresSafeArea()
            .scaledToFill()
    }
}
struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
