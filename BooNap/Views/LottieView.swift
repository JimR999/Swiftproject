//
//  LottieView.swift
//  BooNap
//
//  Created by jamil raai on 14.10.21.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable{
    typealias  UIViewType = UIView
    
    var filename : String
    var animationSpeed : CGFloat
    var loopMode : LottieLoopMode
    var view = UIView(frame: .zero)
    func makeUIView(context: Context) -> UIView {
        
        // Add animation
        let animationView = AnimationView()
        animationView.animation = Animation.named(filename)
        animationView.contentMode = .scaleToFill
        animationView.animationSpeed = animationSpeed
        animationView.loopMode = loopMode
        animationView.restorationIdentifier = "AnimationView"
        self.view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        
        return self.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Do Nothing yet
    }
    
    public func play() {
        for view in self.view.subviews {
            if view.restorationIdentifier == "AnimationView" {
                if !(view as! AnimationView).isAnimationPlaying {
                    (view as! AnimationView).play()
                }
            }
        }
    }
    
    public func stop() {
        for view in self.view.subviews {
            if view.restorationIdentifier == "AnimationView" {
                if (view as! AnimationView).isAnimationPlaying {
                    (view as! AnimationView).stop()
                }
            }
        }
    }
    
    public func pause() {
        for view in self.view.subviews {
            if view.restorationIdentifier == "AnimationView" {
                if (view as! AnimationView).isAnimationPlaying {
                    (view as! AnimationView).pause()
                }
            }
        }
    }
    
    public func playToFrame(toFrame : CGFloat) {
        for view in self.view.subviews {
            if view.restorationIdentifier == "AnimationView" {
                if !(view as! AnimationView).isAnimationPlaying {
                    (view as! AnimationView).play(toFrame: toFrame)
                }
            }
        }
    }
}
