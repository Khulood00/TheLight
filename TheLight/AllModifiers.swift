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
            .bold()
            .font(.system(size: 28))
            .foregroundColor(.black)
            .frame(width: 300.0)
            .transition(.scale)
    }
}
struct TimerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50 , weight: .bold))
            .foregroundColor(.black)
            .padding(.top, 400.0)
            .transition(.scale)
    }
}
struct StartTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
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

