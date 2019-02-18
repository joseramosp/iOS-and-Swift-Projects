//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Jose Ramos on 2/17/19.
//  Copyright © 2019 Jose Ramos. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // The 7 lines are the connections of the buttons on the Play Sounds View Controller
    // Because the extentension, this variables are used on the playsoundsviewcontroller-audio.swift
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // The next set of var declarations are going to be used to control the audio playback
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // This emum are going to be used to create a better abstraction when reading the tag of the buttons.
    enum ButtonType: Int { case slow = 0, fast = 1, chipmunk = 2, vader = 3, echo = 4, reverb = 5 }
    
    // IBAction is connected to all the 6 pitch options.
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    // This IBAction is connected with the stop button. It will stop the audio when is paying.
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    // MARK: Here the next method are going to run to set up the view when the Play Sounds VC is called
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
}
