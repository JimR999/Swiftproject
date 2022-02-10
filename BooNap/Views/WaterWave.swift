//
//  WaterWave.swift
//  BooNap
//
//  Created by jamil raai on 05.02.22.
//

import SwiftUI

struct WaterWave: View {
    var universalSquare = UIScreen.main.bounds
    @State var isAnimated = false
    var body: some View {
        ZStack {
            WaterWaveShape(interval: universalSquare.width,
                           amplitude: 20,
                           baseline: universalSquare.height / 2 - 20)
                .foregroundColor(Color.init(red: 0.3, green: 0.6, blue: 1, opacity: 0.4))
                .offset(x: isAnimated ? -1 * universalSquare.width : 0)
                .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false))
            WaterWaveShape(interval: universalSquare.width,
                           amplitude: 20,
                           baseline: universalSquare.height / 2 - 40)
                .foregroundColor(Color.init(red: 0.3, green: 0.6, blue: 1, opacity: 0.4))
                .offset(x: isAnimated ? -1 * universalSquare.width : 0)
                .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false))
            WaterWaveShape(interval: universalSquare.width,
                           amplitude: 20,
                           baseline: universalSquare.height / 2)
                .foregroundColor(Color.init(red: 0.3, green: 0.6, blue: 1, opacity: 0.4))
                .offset(x: isAnimated ? -1 * universalSquare.width : 0)
                .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false))
        }.onAppear(perform: {
            self.isAnimated = true
        })
        .onDisappear(perform: {
            self.isAnimated = false
        })
    }
}

struct WaterWaveShape: Shape {
    var interval: CGFloat
    var amplitude: CGFloat
    var baseline: CGFloat = UIScreen.main.bounds.height / 2
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: baseline))
        path.addCurve(
            to: CGPoint(x: 1 * interval, y: baseline),
            control1: CGPoint(x: interval * (0.35), y: amplitude + baseline),
            control2: CGPoint(x: interval * (0.65), y: -amplitude + baseline)
        )
        path.addCurve(
            to: CGPoint(x: 2 * interval, y: baseline),
            control1: CGPoint(x: interval * (1.35), y: amplitude + baseline),
            control2: CGPoint(x: interval * (1.65), y: -amplitude + baseline)
        )
        path.addLine(to: CGPoint(x: 2 * interval, y: baseline * 2))
        path.addLine(to: CGPoint(x: 0, y: baseline * 2))
        return path
    }
}

struct WaterWave_Previews: PreviewProvider {
    static var previews: some View {
        WaterWave()
    }
}
