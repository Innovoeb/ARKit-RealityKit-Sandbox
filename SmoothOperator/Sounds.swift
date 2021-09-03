//
//  Sounds.swift
//  SmoothOperator
//
//  Created by Beovonni on 8/23/21.
//

import AVFoundation

 class Sounds
 {
   static var audioPlayer:AVAudioPlayer?

   static func playSounds(soundfile: String)
   {
    // if let = unlock optional values safely if their is a value, of not, do not run the block of code
       if let path = Bundle.main.path(forResource: "SmoothOperator", ofType: "mp3")
       {
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }
        catch
        {
            print("Error")
        }
       }
    }
 }
