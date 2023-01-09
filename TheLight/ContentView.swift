//
//  ContentView.swift
//  TheLight
//
//  Created by Khulood Alhamed on 08/01/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        GeometryReader{ geo in
            ZStack
            {
                Image("nightBackground")
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                
                    
                    
                    
            
                
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
