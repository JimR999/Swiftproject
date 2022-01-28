//
//  Home.swift
//  BooNap
//
//  Created by jamil raai on 21.01.22.
//

import SwiftUI

struct Home: View {
    var animationFileName = Array<String>(arrayLiteral:"18979-boat-on-peaceful-water",
                                                       "11813-bubbles",
                                                       "78292-water-wave-animation",
                                                       "211009-boonap-proto",
                                                       "simple-breathing-animation")
    
    @State private var waterLevel = enumWaterLevel.SunLevel
    @State private var lottieViewList = [LottieView]()
    
    // Liquid Swipe offSet..
    @State private var offset : CGSize = .zero
    @State private var ShowSettings = false

    @State private var opacity : Double = 0
    
    // WaterLevel Object
    @ObservedObject var WaterLevelObject = WaterLevel(displaySize: UIScreen.main.bounds)
    
    @State private var sunWaterLevelViewDidTap = false
    @State private var midWaterLevelViewDidTap = false
    @State private var deepWaterLevelViewDidTap = false
    
    
    @State private var startPoint = UnitPoint(x: 0.5, y: 0)
    @State private var endPoint = UnitPoint(x: 0.5, y: 5)
    init(){
        UIScrollView.appearance().bounces = false
    }
    
//    func viewDidLoad() {
//            // Do any additional setup after loading the view, typically from a nib.
//
//    }
    
    var body: some View {
        
        ZStack{
            
            let sunWaterLevelView : LottieView = LottieView(filename: "18979-boat-on-peaceful-water", animationSpeed: 1, loopMode: .loop)

            let bobbelView : LottieView = LottieView(filename: "11813-bubbles", animationSpeed: 0.5, loopMode: .playOnce)

            let midWaterLevelView : LottieView = LottieView(filename: "78292-water-wave-animation", animationSpeed: 1, loopMode: .loop)

            let deepWaterLevelView : LottieView = LottieView(filename: "simple-breathing-animation", animationSpeed: 1.2, loopMode: .loop)

            SunWaterLevelView(sunWaterLevelView: sunWaterLevelView, bobbleView: bobbelView, opacity: opacity, didTap: $sunWaterLevelViewDidTap)
                .offset(x: 0, y: WaterLevelObject.OffSetSunLevelView)
                .onAppear(perform: {
                    sunWaterLevelView.play()
                    bobbelView.playToFrame(toFrame: 25)
                    lottieViewList.insert(sunWaterLevelView, at: 0)
                    lottieViewList.insert(bobbelView, at: 1)
                    lottieViewList.insert(midWaterLevelView, at: 2)
                    lottieViewList.insert(deepWaterLevelView, at: 3)
                })
                .onChange(of: sunWaterLevelViewDidTap, perform: { value in
                    moveOffSet()
                })

            MidWaterLevelViewTimer(waterView: midWaterLevelView, didTap: $midWaterLevelViewDidTap)
                .offset(x: 0, y: WaterLevelObject.OffSetMidWaterLevelView)
                .onChange(of: midWaterLevelViewDidTap , perform: { value in
                    moveOffSet()
                })

            DeepWaterLevelView(deepWaterView: deepWaterLevelView,didTap: $deepWaterLevelViewDidTap)
                .offset(x: 0, y: WaterLevelObject.OffSetDeepWaterLevelView)
                .onChange(of: deepWaterLevelViewDidTap , perform: { value in
                    moveOffSet()
                })
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(
            LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.8078431487083435, green: 0.886274516582489, blue: 0.929411768913269, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.2078431397676468, green: 0.4274509847164154, blue: 0.6274510025978088, alpha: 1)), location: 0.32),
                    .init(color: Color(#colorLiteral(red: 0.16470588743686676, green: 0.3294117748737335, blue: 0.47843137383461, alpha: 1)), location: 0.65),
                    .init(color: Color(#colorLiteral(red: 0.05882352963089943, green: 0.1568627506494522, blue: 0.24705882370471954, alpha: 1)), location: 1)]),
                startPoint: self.startPoint,
                endPoint: self.endPoint)
                .ignoresSafeArea()
        )
//        .background(
//            LinearGradient(gradient: Gradient(colors: [Color("ColorTop"), Color("ColorMidOne"),Color("ColorMidTwo"),Color("ColorBottom")]), startPoint: self.startPoint, endPoint: self.endPoint).ignoresSafeArea()
//        )
    }
    
    func moveOffSet(){
        withAnimation(.easeOut(duration: 2.5)){
            
//            let smaleView = lottieViewList[1]
            self.startPoint = UnitPoint(x: 0.5, y: -0.65)
            self.endPoint = UnitPoint(x: 0.5, y: 1)
//            switch waterLevel {
//                case .SunLevel:
//                    waterLevel = .MidWaterLevel
//                    smaleView.play()
//                    self.WaterLevelObject.OffSetSunLevelView = -UIScreen.main.bounds.height
//                    self.WaterLevelObject.OffSetMidWaterLevelView = 0
//                    self.WaterLevelObject.OffSetDeepWaterLevelView = UIScreen.main.bounds.height
//                    self.startPoint = UnitPoint(x: 0.5, y: 3)
//                    self.endPoint = UnitPoint(x: 0.5, y: 1.5)
//                case .MidWaterLevel:
//                    waterLevel = .DeepWaterLevel
//                    self.WaterLevelObject.OffSetSunLevelView = -UIScreen.main.bounds.height * 2
//                    self.WaterLevelObject.OffSetMidWaterLevelView = -UIScreen.main.bounds.height
//                    self.WaterLevelObject.OffSetDeepWaterLevelView = 0
////                    Sounds.playSounds(soundfile: "atmung.mp3")
//                case .DeepWaterLevel:
//                    waterLevel = .SunLevel
//                    smaleView.playToFrame(toFrame: 25)
//                    self.WaterLevelObject.OffSetSunLevelView = 0
//                    self.WaterLevelObject.OffSetMidWaterLevelView = UIScreen.main.bounds.height
//                    self.WaterLevelObject.OffSetDeepWaterLevelView = UIScreen.main.bounds.height * 2
////                    Sounds.stopSounds()
//            }
//
//            let view = lottieViewList[waterLevel.rawValue]
//            view.play()
//            lottieViewList[waterLevel.rawValue] = view
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
