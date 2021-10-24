//
//  ContentView.swift
//  BooNap
//
//  Created by jamil raai on 14.10.21.
//

import SwiftUI
import Lottie

struct ContentView: View {
    
    var animationFileName = Array<String>(arrayLiteral:"18979-boat-on-peaceful-water",
                                                       "11813-bubbles",
                                                       "78292-water-wave-animation",
                                                       "211009-boonap-proto")
    @State private var contentOffset: CGPoint = .zero
    @State private var currentYCord : CGFloat = 0
    @State private var waterLevel = enumWaterLevel.SunLevel
    @State private var lottieViewList = [LottieView]()
    @State var lottieViewIndex = 0
    
    // Liquid Swipe offSet..
    @State private var offset : CGSize = .zero
    @State private var ShowSettings = false

    @State private var opacity : Double = 0
    
    /// WaterLevel Object
    @ObservedObject var WaterLevelObject = WaterLevel(displaySize: UIScreen.main.bounds)
    
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                    let view : LottieView = LottieView(filename: animationFileName[0], animationSpeed: 1, loopMode: .loop)

                    let bobbelView : LottieView = LottieView(filename: animationFileName[1], animationSpeed: 0.5, loopMode: .playOnce)

                    getSunLevelView(view: view,bobbelView: bobbelView )
                        .offset(x: 0, y: WaterLevelObject.OffSetSunLevelView)
                        .onAppear(perform: {
                            view.play()
                            bobbelView.playToFrame(toFrame: 25)
                        })


                    let waterView : LottieView = LottieView(filename: animationFileName[2], animationSpeed: 1, loopMode: .loop)

                    getFirstWaterLevelView(waterView: waterView)
                        .offset(x: 0, y: WaterLevelObject.OffSetMidWaterLevelView)

                    let booView : LottieView = LottieView(filename: animationFileName[3], animationSpeed: 1, loopMode: .loop)

                    booView.aspectRatio(contentMode: .fill)
                        .offset(x: 0, y: WaterLevelObject.OffSetDeepWaterLevelView)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .cornerRadius(6.0)
                        .onAppear(perform: {
                            lottieViewList.insert(view, at: 0)
                            lottieViewList.insert(bobbelView, at: 1)
                            lottieViewList.insert(waterView, at: 2)
                            lottieViewList.insert(booView, at: 3)
                        })
                }
            ZStack {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 50)
                    .foregroundColor(.blue.opacity(0.2))
                    .onTapGesture(perform: {
                        withAnimation(.easeOut(duration: 2.5)){
                            let smaleView = lottieViewList[1]
                            var view = lottieViewList[waterLevel.rawValue]
                            view.stop()
                            lottieViewList[waterLevel.rawValue] = view

                            switch waterLevel {
                                case .SunLevel:
                                    waterLevel = .MidWaterLevel
                                    smaleView.play()
                                    self.currentYCord += UIScreen.main.bounds.height + 10
//
                                    self.WaterLevelObject.OffSetSunLevelView = -currentYCord
                                    self.WaterLevelObject.OffSetMidWaterLevelView = 0
                                case .MidWaterLevel:
                                    waterLevel = .DeepWaterLevel
                                    self.currentYCord += UIScreen.main.bounds.height + 10
                                    
                                    self.WaterLevelObject.OffSetSunLevelView += -currentYCord
                                    self.WaterLevelObject.OffSetMidWaterLevelView = -currentYCord
                                    self.WaterLevelObject.OffSetDeepWaterLevelView = 0
                                case .DeepWaterLevel:
                                    waterLevel = .SunLevel
                                    smaleView.playToFrame(toFrame: 25)
                                    self.currentYCord = 0
                                    self.WaterLevelObject.OffSetSunLevelView = 0
                                    self.WaterLevelObject.OffSetMidWaterLevelView = UIScreen.main.bounds.height
                                    self.WaterLevelObject.OffSetDeepWaterLevelView = UIScreen.main.bounds.height * 2
                            }

                            view = lottieViewList[waterLevel.rawValue]
                            view.play()
                            lottieViewList[waterLevel.rawValue] = view
                        }
                    })
                Image(systemName: waterLevel == .DeepWaterLevel ? "arrow.up" : "arrow.down")
                    .font(.largeTitle)
                    .aspectRatio(contentMode: .fill)

            }
        }.ignoresSafeArea(.all)
        
    }
    
    func getSunLevelView(view : LottieView, bobbelView : LottieView) -> some View {
        
        return ZStack {

                    view.aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width)
                        .cornerRadius(6.0)

                    ZStack {

                        bobbelView.aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width)
                            .cornerRadius(6.0)
                            .onTapGesture {
                                withAnimation(.easeIn){
                                    print("ease")
                                }
                            }
                            .onAppear(perform: {
                                bobbelView.playToFrame(toFrame: 25)
                            })
                        
                        Button(action: {
                        }, label: {
                            Text("Let's Dive in ...")
                                .frame(width: 250, height: 150)
                                .padding()
                                .opacity(opacity)
                                .foregroundColor(.white)
                                .font(.headline)
                                .cornerRadius(20)
                                .offset(y: -35)
                        })
                        .onAppear(perform: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8, execute: {
                                withAnimation(.linear.delay(0)){
                                    opacity = 1
                                }
                            })
                        })
                    }
                    .frame(width: 250, height: 250)
                    .offset(y: 270)

            }
             .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func getFirstWaterLevelView(waterView : LottieView ) -> some View {
        return ZStack {
            
                Color("Test")
                
                Rectangle()
                    .foregroundColor(Color.init("AccentColor"))
                    .overlay(
                        waterView.aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                             .cornerRadius(6.0)
                    )
                    .background(Color.white)
                    .clipShape(LiquidSwipe(offset: offset))
                    .ignoresSafeArea(.all)
                    .overlay(
                        Image(systemName: "chevron.left")
                            .font(.largeTitle)
                            .frame(width: 50, height: 50)
                            .contentShape(Rectangle())
                            .gesture(DragGesture().onChanged({ (value) in
                                // animation Swipe offset...
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                    offset = value.translation
                                }
                            }).onEnded({ (value) in
                                let screen = UIScreen.main.bounds
                                withAnimation(.spring()) {
                                    if -offset.width > screen.width / 2 {
                                        offset.width = -screen.height
                                        ShowSettings.toggle()
                                    } else {
                                        offset = .zero
                                    }
                                }
                            }))
                            .offset(x: 10, y: 100)
                            .opacity(offset == .zero ? 1 : 0)
                        , alignment: .topTrailing
                    )
                
                if ShowSettings {
                    Image("Vertical")
                        .onTapGesture {
                            withAnimation(.spring()) {
                                offset = .zero
                                ShowSettings.toggle()
                            }
                        }
                }
        }
        .background(Color.blue)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
