//
//  WaterLevel.swift
//  BooNap
//
//  Created by jamil raai on 24.10.21.
//

import SwiftUI

class WaterLevel: ObservableObject {
    
    init(displaySize : CGRect) {
        OffSetMidWaterLevelView = displaySize.height
        OffSetDeepWaterLevelView = displaySize.height * 2
    }
    
    @Published var OffSetSunLevelView : CGFloat = 0
    @Published var OffSetMidWaterLevelView : CGFloat = 0
    @Published var OffSetDeepWaterLevelView : CGFloat = 0
    
}


enum enumWaterLevel : Int {
    case SunLevel = 0
    case MidWaterLevel = 2
    case DeepWaterLevel = 3
}

struct SunWaterLevelView : View {
    
    @State private var sunWaterLevelView : LottieView
    @State private var bobbelView : LottieView
    @State private var opacity : Double
    @Binding private var didTap : Bool
    
    init(sunWaterLevelView : LottieView, bobbleView : LottieView, opacity : Double, didTap : Binding<Bool> ) {
        self.sunWaterLevelView = sunWaterLevelView
        self.bobbelView = bobbleView
        self.opacity = opacity
        self._didTap = didTap
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.8078431487083435, green: 0.886274516582489, blue: 0.929411768913269, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.2078431397676468, green: 0.4274509847164154, blue: 0.6274510025978088, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1))
//            sunWaterLevelView.aspectRatio(contentMode: .fit)
//                .frame(width: UIScreen.main.bounds.width)
//                .cornerRadius(6.0)
            
            ZStack {
                
                bobbelView.aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                    .cornerRadius(6.0)
                    .onAppear(perform: {
                        bobbelView.playToFrame(toFrame: 25)
                    })
                
                
                Text("Let's Dive in...")
                    .frame(width: 250, height: 150)
                    .padding()
                    .opacity(opacity)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(20)
                    .offset(y: -35)
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6, execute: {
                            withAnimation(.linear.delay(0)){
                                opacity = 1
                            }
                        })
                    })
                    .onTapGesture(perform: {
                        didTap.toggle()
                    })
            }
            .frame(width: 250, height: 250)
            .offset(y: 270)
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

struct MidWaterLevelView : View {
    
    @State var waterView : LottieView
    
    @State var offset : CGSize
    @State var ShowSettings : Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.init("FirstWaterLevel"))
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
                            withAnimation(.spring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
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
        .background(Color.init("BackgroundColor"))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
    }
}

struct MidWaterLevelViewTimer : View {
    
    @State var waterView : LottieView
    
    @Binding var didTap : Bool
    
    @State private var selectedPickerIndexMin = 0
    @State private var selectedPickerIndexHour = 0
    private let availableMinutes = Array(0...59)
    private let availableHours = Array(0...23)
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack {
                Spacer()
                Text("How long would you \n       like to nap?")
                    .font(Font.custom("RoundedMplus1c-Medium", size: 35))
                    .foregroundColor(Color("TextColor"))
                
                Spacer()
                
                HStack {
                    
                    CustomPicker(dataArrays: availableHours, selections: $selectedPickerIndexHour)
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: UIScreen.main.bounds.width / 3)
                        .clipped()
                        .onChange(of: selectedPickerIndexHour ) { index in
                            
                            
                        }
                        .labelsHidden()
                    
                    Text(" : ")
                        .frame(width: 20, alignment: .center)
                        .foregroundColor(Color("TextColor"))
                        .font(Font.custom("RoundedMplus1c-Medium", size: 35))
                        .offset(y: -30.0)
                    
                    CustomPicker(dataArrays: availableMinutes, selections: $selectedPickerIndexMin)
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: UIScreen.main.bounds.width / 3)
                        .clipped()
                        .onChange(of: selectedPickerIndexMin ) { index in
                            
                        }
                        .labelsHidden()
                }
                .frame(width: 300)
                
                Spacer()
                VStack{
                    Text("Go Nap!")
                        .font(Font.custom("RoundedMplus1c-Medium", size: 30))
                        .foregroundColor(Color("TextColor"))
                    Image(systemName: "arrow.down")
                        .resizable()
                        .foregroundColor(Color("TextColor"))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                }
                .onTapGesture {
                    didTap.toggle()
                }
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
            
            Spacer()
            
            Text("Show me how \n   to nap first.")
                .font(Font.custom("RoundedMplus1c-Medium", size: 15))
                .foregroundColor(Color("TextColor"))
            
            Spacer()
        }
        .background(
            LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.2078431397676468, green: 0.4274509847164154, blue: 0.6274510025978088, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.16470588743686676, green: 0.3294117748737335, blue: 0.47843137383461, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1))
        )
    }
}

struct DeepWaterLevelView : View {
    
    @State var deepWaterView : LottieView
    @Binding var didTap : Bool
    
    var body: some View {
        ZStack{
            LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.16470588743686676, green: 0.3294117748737335, blue: 0.47843137383461, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.05882352963089943, green: 0.1568627506494522, blue: 0.24705882370471954, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1))
            deepWaterView
                .padding(30)
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2)
                .onTapGesture {
                    didTap.toggle()
                }
        }
    }
}

