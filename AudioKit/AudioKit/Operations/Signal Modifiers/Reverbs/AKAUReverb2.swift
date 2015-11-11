//
//  AKAUReverb2.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import AVFoundation

#if os(iOS)

/** AudioKit version of Apple's Reverb2 Audio Unit */
public class AKAUReverb2: AKOperation {
    
    private let cd = AudioComponentDescription(
        componentType: kAudioUnitType_Effect,
        componentSubType: kAudioUnitSubType_Reverb2,
        componentManufacturer: kAudioUnitManufacturer_Apple,
        componentFlags: 0,
        componentFlagsMask: 0)
    
    private var internalEffect = AVAudioUnitEffect()
    private var internalAU = AudioUnit()
    
    /** Dry Wet Mix (CrossFade) ranges from 0 to 100 (Default: 100) */
    public var dryWetMix: Float = 100 {
        didSet {
            if dryWetMix < 0 {
                dryWetMix = 0
            }
            if dryWetMix > 100 {
                dryWetMix = 100
            }
            AudioUnitSetParameter(internalAU, kReverb2Param_DryWetMix, kAudioUnitScope_Global, 0, dryWetMix, 0)
        }
    }
    
    /** Gain (Decibels) ranges from -20 to 20 (Default: 0) */
    public var gain: Float = 0 {
        didSet {
            if gain < -20 {
                gain = -20
            }
            if gain > 20 {
                gain = 20
            }
            AudioUnitSetParameter(internalAU, kReverb2Param_Gain, kAudioUnitScope_Global, 0, gain, 0)
        }
    }
    
    /** Min Delay Time (Secs) ranges from 0.0001 to 1.0 (Default: 0.008) */
    public var minDelayTime: Float = 0.008 {
        didSet {
            if minDelayTime < 0.0001 {
                minDelayTime = 0.0001
            }
            if minDelayTime > 1.0 {
                minDelayTime = 1.0
            }
            AudioUnitSetParameter(internalAU, kReverb2Param_MinDelayTime, kAudioUnitScope_Global, 0, minDelayTime, 0)
        }
    }
    
    /** Max Delay Time (Secs) ranges from 0.0001 to 1.0 (Default: 0.050) */
    public var maxDelayTime: Float = 0.050 {
        didSet {
            if maxDelayTime < 0.0001 {
                maxDelayTime = 0.0001
            }
            if maxDelayTime > 1.0 {
                maxDelayTime = 1.0
            }
            AudioUnitSetParameter(internalAU, kReverb2Param_MaxDelayTime, kAudioUnitScope_Global, 0, maxDelayTime, 0)
        }
    }
    
    /** Decay Time At0 Hz (Secs) ranges from 0.001 to 20.0 (Default: 1.0) */
    public var decayTimeAt0Hz: Float = 1.0 {
        didSet {
            if decayTimeAt0Hz < 0.001 {
                decayTimeAt0Hz = 0.001
            }
            if decayTimeAt0Hz > 20.0 {
                decayTimeAt0Hz = 20.0
            }
            AudioUnitSetParameter(internalAU, kReverb2Param_DecayTimeAt0Hz, kAudioUnitScope_Global, 0, decayTimeAt0Hz, 0)
        }
    }
    
    /** Decay Time At Nyquist (Secs) ranges from 0.001 to 20.0 (Default: 0.5) */
    public var decayTimeAtNyquist: Float = 0.5 {
        didSet {
            if decayTimeAtNyquist < 0.001 {
                decayTimeAtNyquist = 0.001
            }
            if decayTimeAtNyquist > 20.0 {
                decayTimeAtNyquist = 20.0
            }
            AudioUnitSetParameter(internalAU, kReverb2Param_DecayTimeAtNyquist, kAudioUnitScope_Global, 0, decayTimeAtNyquist, 0)
        }
    }
    /** Decay Time (Secs) ranges from 0.001 to 20.0 (Default: 0.5) 
     Sets both atNyquist and at0Hz decay times*/
    public var decayTime: Float = 0.5 {
        didSet {
            if decayTime < 0.001 {
                decayTime = 0.001
            }
            if decayTime > 20.0 {
                decayTime = 20.0
            }
            AudioUnitSetParameter(internalAU, kReverb2Param_DecayTimeAtNyquist, kAudioUnitScope_Global, 0, decayTime, 0)
            AudioUnitSetParameter(internalAU, kReverb2Param_DecayTimeAt0Hz, kAudioUnitScope_Global, 0, decayTime, 0)
        }
    }
    
    /** Randomize Reflections (Integer) ranges from 1 to 1000 (Default: 1) */
    public var randomizeReflections: Float = 1 {
        didSet {
            if randomizeReflections < 1 {
                randomizeReflections = 1
            }
            if randomizeReflections > 1000 {
                randomizeReflections = 1000
            }
            AudioUnitSetParameter(internalAU, kReverb2Param_RandomizeReflections, kAudioUnitScope_Global, 0, randomizeReflections, 0)
        }
    }
    
    /** Initialize the reverb2 operation */
    public init(
        _ input: AKOperation,
        dryWetMix: Float = 100,
        gain: Float = 0,
        minDelayTime: Float = 0.008,
        maxDelayTime: Float = 0.050,
        decayTimeAt0Hz: Float = 1.0,
        decayTimeAtNyquist: Float = 0.5,
        randomizeReflections: Float = 1)
    {
        self.dryWetMix = dryWetMix
        self.gain = gain
        self.minDelayTime = minDelayTime
        self.maxDelayTime = maxDelayTime
        self.decayTimeAt0Hz = decayTimeAt0Hz
        self.decayTimeAtNyquist = decayTimeAtNyquist
        self.randomizeReflections = randomizeReflections
        super.init()
        
        internalEffect = AVAudioUnitEffect(audioComponentDescription: cd)
        output = internalEffect
        AKManager.sharedInstance.engine.attachNode(internalEffect)
        AKManager.sharedInstance.engine.connect(input.output!, to: internalEffect, format: nil)
        internalAU = internalEffect.audioUnit
    }
}

#endif
