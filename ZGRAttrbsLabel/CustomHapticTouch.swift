//
//  CustomHapticTouch.swift
//  ZGRAttrbsLabel
//
//  Created by Mac on 30.11.2020.
//

import Foundation
import CoreHaptics

class CustomHapticTouch {
    static let shared : CustomHapticTouch = CustomHapticTouch()
    fileprivate var engine : CHHapticEngine?
    init() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        do {
            self.engine = try CHHapticEngine()
            try self.engine?.start()
        }catch {
            print("Error haptic : \(error.localizedDescription)")
        }
    }
    
    
    func playHaptic() {
        guard let engine = self.engine else {return}
        let hapticDict = [
            CHHapticPattern.Key.pattern: [
                [CHHapticPattern.Key.event: [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                                             CHHapticPattern.Key.time: 0.1,
                      CHHapticPattern.Key.eventDuration: 1.0]
                ]
            ]
        ]
        do {
            let pattern = try CHHapticPattern(dictionary: hapticDict)
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        }catch {
            print("Error haptic : \(error.localizedDescription)")
        }
    }
    
    
}
