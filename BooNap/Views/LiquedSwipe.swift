//
//  LiquedSwipe.swift
//  BooNap
//
//  Created by jamil raai on 20.10.21.
//

import SwiftUI

struct ExampleView: View {
    
    // Liquid Swipe Offset...
    @State private var offset : CGSize = .zero

    @State private var ShowSettings = false

    var body: some View {
        // Example View
        ZStack {
            let views : LottieView = LottieView(filename:"211009-boonap-proto", animationSpeed: 1, loopMode: .loop)
            
            Color("AccentColor")
                .overlay(
                    views.aspectRatio(contentMode: .fill)
                        .background(Color.black)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .cornerRadius(6.0)
                )
                .clipShape(LiquidSwipe(offset: offset))
                .ignoresSafeArea()
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
                        .offset(x: 10, y: 55)
                        .opacity(offset == .zero ? 1 : 0)
                    , alignment: .topTrailing
                )
            
            if ShowSettings {
                Text("JA KL")
                    .onTapGesture {
                        withAnimation(.spring()) {
                            offset = .zero
                            ShowSettings.toggle()
                        }
                    }
            }
        }
    }
}

//struct test_Previews: PreviewProvider {
//    static var previews: some View {
//        ExampleView()
//    }
//}

struct LiquidSwipe : Shape {
    
    var offset : CGSize
    
    var animatableData: CGSize.AnimatableData{
        get{return offset.animatableData}
        set{offset.animatableData = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            
                let width = rect.width + (-offset.width > 0 ? offset.width : 0)
                
                path.move(to: CGPoint(x:0 , y: 0))
                path.addLine(to: CGPoint(x: rect.width, y: 0))
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
                
                
                let from = 80 + (offset.width)
                path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
                
                var to = 180 + (offset.height) + ( -offset.width)
                to = to < 180 ? 180 : to
                
                let mid : CGFloat = 80 + ((to - 80) / 2)
            
                path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))
            
            }
    }
}
