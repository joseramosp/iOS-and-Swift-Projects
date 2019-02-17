//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jose Ramos on 2/16/19.
//  Copyright © 2019 Jose Ramos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var recordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func RecordAudio(_ sender: Any) {
        print("Record button was pressed")
        recordLabel.text = "Recording..."
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        print("Stop recording button was pressed")
    }
}

