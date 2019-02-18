//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Jose Ramos on 2/16/19.
//  Copyright © 2019 Jose Ramos. All rights reserved.
//

import UIKit
import AVFoundation  // This will be the pack that will give all audio methods

// In other to delegate and AVFoundation to a variable, we need to inherit AVAudioRecorderDelegate
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // Creating a varible of type AVAudioRecorder 
    var audioRecorder: AVAudioRecorder!
    
    // The next three IBOutlet are connect with the Start Record and Stop Recoding buttons, and the label
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    // This viewDidLoad method will disable the stop button when the Record Sounds VC is called
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // The next method will be called when the Start Recording button is pressed
    // This method will store the audio in a location and save that URL in a constant
    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        // The next try! will ignore the line if it fails, this avoid a crash on the app.
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self         // Delegating the AVFoundation property
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // This method will be called when the Stop Recording button is pressed.
    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = true               // This line is enabling the record button
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // This is the method that will switch the app to the Play Sounds VC.
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            print("Recording was not succesful")
        }
    }
    
    // This is the method that will prepare the segue with the identifier "stopRecording" to the Play Sounds VC.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            // This will send the URL of the auidio to the playSoundsVC.
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

