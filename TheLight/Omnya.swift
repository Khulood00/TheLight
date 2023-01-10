//
//  Omnya.swift
//  TheLight
//
//  Created by Omnya Kamal  on 08/01/2023.
//

import SwiftUI
import AVFoundation


struct Omnya: View {
    //__________All Used Variables__________//
    @State var isClicked = false //To check if the Tab to start button is clicked or not
    @State var HideStartButton = false
    @State private var HideExeImg = false // To show and hide exercise img
    @State var countDownTimer = 10 //countDownTimer -> starting the count down from 5.
    @State var player: AVAudioPlayer!
    @State var isTimerRunning = true
    @State private var randNum = Int.random(in: 1...11)//randNum -> Generate rand num between 1 & 11 to be used to choose rand imgs from assets.
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() //.autoconnect() to start the timer automatically.
    //__________End of Variables__________//
    
    var body: some View {
        ZStack{
            //Calling Background View:
            Morningbackground()
            
            /*NOTE: Circles Views aarrnged from outter to inner:*/
            
            if isClicked {
                OuterAnimatedCircle()
            }//To animate the outer circle only when clicking on the start button.
            
            //Circles views:
            MiddleCircle()
            InnerCircle()
            //Tab to start button:
            Button {
                self.isClicked.toggle()
                self.HideStartButton = true
                self.isClicked = true
                //To play the music:
                let url = Bundle.main.url(forResource: "10secMusic", withExtension: "mp3")
                guard url != nil else {
                    print("Not playing sound")
                    return
                }//End of else.
                do{
                    player = try AVAudioPlayer(contentsOf: url!)
                    player?.play()
                } catch {
                    print("Catch Error")
                }//End of catch.
            } label: {
                Text("Tab to start")
                    .modifier(StartTextModifier())
                    .opacity(HideStartButton ? 0 : 1)
                    .transition(.scale)
            }//End of Button & label
            
            //Showing exercise Img:
            if isClicked{
                //ForEach(1...3, id: \.self) { i in
                    Image("yoga" + String(randNum))
                        .resizable()
                        .frame(width: 170.0, height: 170.0)
                        .transition(.scale)
                    //.padding(.top, 450.0)
                        .opacity(HideExeImg ? 0 : 1)
                    //                .animation(.easeIn(duration: 10), value: HideExeImg)
                    //                            .onAppear{
                    //                                self.HideExeImg.toggle()
                    //_________Timer__________//
                    Text("\(countDownTimer)")
                        .onReceive(timer) { _ in
                            if countDownTimer > 0 && isTimerRunning {
                                countDownTimer -= 1
                            } else {
                                isTimerRunning = false
                                HideExeImg = true
                            }
                            
                        }
                    
                        .opacity(isTimerRunning ? 0.50 : 0)
                        .modifier(TimerModifier())
                    
                }//End of if isClicked
                if HideExeImg {
                    VStack{
                        Text("Done!")
                            .modifier(TheEndTextModifier())
                        Text("Have a nice day")
                            .modifier(TheEndTextModifier())
                        
                    }
                }
                
                //Running the timer:
                
                //            Button{
                //
                //            } label:{
                //                Text("Stop").fontWeight(.bold).font(.title2).offset(x: -100.0, y: 200.0).foregroundColor(.black)}
                
                //Spacer()
                //                Text("Next").font(.title2).fontWeight(.bold).offset(x: 100.0, y: 200.0)
                //Spacer()
        }//End of Zstack
    }//End of body
    
}//End of main View

struct Omnya_Previews: PreviewProvider {
    static var previews: some View {
        Omnya()
    }
}


//All the structs that are used:
struct OuterAnimatedCircle: View{
    @State private var animate = false
    //First Circle "Animated":
    var body: some View{
        Circle().fill(Color("MorningCircle"))
            .frame(width: 250, height: 250)
            .scaleEffect(animate ? 1.4 : 1.2)
            .animation(Animation.easeInOut(duration: 1) .repeatCount(10, autoreverses: true))// (duration: 1) --> Means each animation is for 1 sec and .repeatCount(10, autoreverses: true) --> repeat for 20 times means a total of 20 sec , autoreverses: true --> means repeat automatically.
            .onAppear{
                self.animate.toggle()
            }
            .opacity(0.25)
    }
}
struct MiddleCircle: View{
    //Second Circle:
    var body: some View{
        Circle().fill(Color("MorningCircle"))
            .frame(width: 300, height: 300)
            .opacity(0.5)
    }
}
struct InnerCircle: View{
    //Third Circle:
    var body: some View{
        Circle().fill(Color("MorningCircle"))
            .frame(width: 250, height: 250)
    }
}
struct Morningbackground: View{
    //Backgroung Img:
    var body: some View{
        Image("morningBackground")
            .ignoresSafeArea()
            .scaledToFill()
    }
}
class MyMusic{
    @State var player: AVAudioPlayer!
    func playerSound(){
        let url = Bundle.main.url(forResource: "excerciseMusic", withExtension: "mp3")
        guard url != nil else {
            print("Not playing sound")
            return
        }
        do{
            player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
        } catch {
            print("Catch Error")
        }
    }
}
