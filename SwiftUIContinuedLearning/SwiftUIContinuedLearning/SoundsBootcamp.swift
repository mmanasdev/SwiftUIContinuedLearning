//
//  SoundsBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Miguel Mañas Alvarez on 17/10/24.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada
        case badum
    }
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
        
    }
    
}

struct SoundsBootcamp: View {
    
    var soundManager = SoundManager()
    
    var body: some View {
        VStack(spacing: 40) {
            Button("play sound 1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            Button("play sound 2") {
                SoundManager.instance.playSound(sound: .badum)
            }
        }
    }
}

struct SoundsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBootcamp()
    }
}
