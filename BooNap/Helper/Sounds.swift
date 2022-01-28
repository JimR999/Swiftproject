//
//  Sound.swift
//  BooNap
//
//  Created by jamil raai on 21.01.22.
//

import AVFoundation

public class Sounds {

   static var audioPlayer:AVAudioPlayer?

   static func playSounds(soundfile: String) {

    if let path = Bundle.main.path(forResource: soundfile, ofType: nil){
        
           do{

               audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
               audioPlayer?.prepareToPlay()
               audioPlayer?.play()

           }catch {
               print("Error")
           }
       }
    }
    
    static func stopSounds() {

        do{

            audioPlayer?.stop()

        }catch {
            print("Error")
        }
     }
 }
