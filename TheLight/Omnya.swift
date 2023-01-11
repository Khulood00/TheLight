//
//  Omnya.swift
//  TheLight
//
//  Created by Omnya Kamal  on 08/01/2023.
//

import SwiftUI
import AVFoundation
import Accessibility

struct Omnya: View {
    //__________Used Variables__________//
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State var isClicked = false //To check if the Tab to start button is clicked or not
    @State var HideStartButton = false
    @State var player: AVAudioPlayer? //This is used with playAudioWithDelay() func
    @State var countDownTimer = 10 //countDownTimer -> starting the count down from the assigned value.
    @State private var HideExeImg = false // To show and hide exercise img
    // @State var player: AVAudioPlayer! //This is used when playing the sound immediatly when the button tapped.
    @State var isMusicPlayed = true
    @State var isTimerRunning = true
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
                
                playAudioWithDelay()//This is to play beep sound after the countDown is done.
                
                //To play the music only when sart tabbed in the beginning:
                //                if isMusicPlayed {
                //                    let url = Bundle.main.url(forResource: "10secMusic", withExtension: "mp3")
                //                    guard url != nil else {
                //                        print("Not playing sound")
                //                        return
                //                    }//End of else.
                //                    do{
                //                        player = try AVAudioPlayer(contentsOf: url!)
                //                        player?.play()
                //                    } catch {
                //                        print("Catch Error")
                //                    }//End of catch.
                //                }
            } label: {
                Text("Tab to start")
                    .modifier(StartTextModifier())
                    .opacity(HideStartButton ? 0 : 1)
                    .transition(.scale)
                    .accessibilityLabel("Tab to start")
            }//End of Button & label
            
            //Showing exercise Img:
            if isClicked{
                //ForEach(1...3, id: \.self) { i in
                //Image("yoga" + String(randNum),
                // label: Text("Excercise"))
                // To check if  ExerciseImg view should be hidden or not:
                if(!HideExeImg){ExerciseImg()}else{ExerciseImg().hidden()}
                
                
                //_________Timer__________//
                Text("\(countDownTimer)")
                    .onReceive(timer) { _ in
                        if countDownTimer > 0 && isTimerRunning {
                            countDownTimer -= 1
                        } else {
                            isTimerRunning = false
                            HideExeImg = true
                            isMusicPlayed = false
                        }
                        
                    }
                    .accessibilityAddTraits(.updatesFrequently)
                //.accessibilityHidden(true)
                    .opacity(isTimerRunning ? 0.50 : 0)
                    .modifier(TimerModifier())
                
            }//End of if isClicked
            
            if HideExeImg {
                VStack{
                    Text("Done!")
                        .modifier(TheEndTextModifier())
                        .accessibilityLabel("Done!")
                    Text("Have a nice day")
                        .modifier(TheEndTextModifier())
                        .accessibilityLabel("Have a nice day")
                    
                }
            }
            
        }//End of Zstack
        
    }//End of body
    
    //This 2 function together to play audio with delay but does not work:
    func playAudioWithDelay()
    {
        let file = Bundle.main.url(forResource: "DoneSound", withExtension: "mp3")
        
        do {
            player = try AVAudioPlayer(contentsOf: file!)
            player?.volume = 0.7
            player?.numberOfLoops = 0
            player?.prepareToPlay()
            
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
        
        
        let seconds = 60.0//Time To Delay
        let when = DispatchTime.now() + seconds
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.play()
            
        }
    }
    
    func play() {
        if player?.isPlaying == false {
            player?.play()
        }
    }
}//End of main View

struct Omnya_Previews: PreviewProvider {
    static var previews: some View {
        Omnya()
    }
}


//All the structs that are used:
struct OuterAnimatedCircle: View{
    @State private var animate = false
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    //First Circle "Animated":
    var body: some View{
        // NOTE: Accessibility reduceMotion is implemented here, to test it you should go to the simulator then accessibility then turn on reduceMotion and then it will work.
        // NOTE: ReduceMotion means we will not having animation for the outer circle that is useful for hyperactive people.
        Circle().fill(Color("MorningCircle"))
            .frame(width: 250, height: 250)
            .scaleEffect(animate ? 1.4 : 1.2)
            .animation(reduceMotion ? nil : .easeInOut(duration: 1) .repeatCount(60, autoreverses: true))// (duration: 1) --> Means each animation is for 1 sec and .repeatCount(60, autoreverses: true) --> repeat for 60 times means a total of 60 sec , autoreverses: true --> means repeat automatically.
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
struct ExerciseImg: View{
    //Images that are used to choose from them randomly.
    let exeImages = ["yoga1","yoga2","yoga3","yoga4","yoga5","yoga6","yoga7","yoga7","yoga9","yoga10"]
    //exeLabels used for voice over to explain the shown exe mg.
    let exeLabels = ["Exercise Sitting on the floor, bend knees and open them out to the side and the soles of your feet together","Exercise Stand with your legs side by side and bend the upper part so that your chest is touching your thighs and your arms are wrapped around your knees","Exercise Stand with your legs side by side, then raise one foot to touch the knee of the other leg","Exercise Lie on the floor and bend your knees towards the top while your feet on the floor","Exercise Stand on the floor and bend the upper part to till your hands touch the floor","Exercise Sit on the floor, bend one knee, straighten the other leg to the side, and extend one arm towards the straight leg","Exercise Stand on the floor and bend one of your knees forward with your feet on the ground and straighten the other leg towards the back while your stretching your arms forward and backward","Exercise Stand on the floor using one leg and raise other one with your knee bent and straighten one of your arms and bend the other to make it touch your hip","Exercise Stand on the floor with one leg and bent the other one backward, holding your foot with one hand and the other one straight forward","Exercise Lie facing the floor and place your elbows on the floor to raise your body while your toes touching the floor"]
    
    @State private var randNum = Int.random(in: 0...9)//randNum -> Generate rand num between 0 & 9 to be used as index to choose rand imgs from exeImages[] list.
    
    var body: some View{
        Image(exeImages[randNum])
            .resizable()
            .frame(width: 170.0, height: 170.0)
            .transition(.scale)
        //.opacity(HideExeImg ? 0 : 1)
            .onAppear(){
                randNum = Int.random(in: 0...10)
                print(exeLabels[randNum])
            }
        
            .accessibilityLabel(exeLabels[randNum])
        
    }
}

//This class was to play the music but it does not work.
/*class MyMusic{
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
 }*/


