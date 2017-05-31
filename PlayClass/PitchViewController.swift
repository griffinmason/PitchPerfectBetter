//
//  PitchViewController.swift
//  PlayClass
//
//  Created by Sanjana Sarkar on 5/30/17.
//  Copyright © 2017 Sanjana Sarkar. All rights reserved.
//

import UIKit
import AVFoundation

class PitchViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var playOneB: UIButton!
    var audioPlayer : AVAudioPlayer?
    var url: URL?
    var recorder: AVAudioRecorder?
    var engine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioPlayerNode: AVAudioPlayerNode!
    
    
    @IBOutlet weak var playTwoB: UIButton!
    @IBOutlet weak var playThreeB: UIButton!
    
    @IBOutlet weak var stopB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(
                AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        engine = AVAudioEngine()
        
//        do {
//            try audioFile = AVAudioFile(forReading: url!)
//        } catch let error as NSError {
//            print("audioFile error: \(error.localizedDescription)")
//        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func playOne(_ sender: UIButton) {
        playSound(value: 1000, rateOrPitch: "pitch")
    }
    
    @IBAction func playTwo(_ sender: UIButton) {
        playSound(value: -1000, rateOrPitch: "pitch")
    }
    
    @IBAction func playThree(_ sender: UIButton) {
    }
    
    func playSound(value: Float, rateOrPitch: String){
        audioPlayerNode = AVAudioPlayerNode()
        let changeAudioUnitTime = AVAudioUnitTimePitch()
        
        engine.attach(audioPlayerNode!)
        engine.attach(changeAudioUnitTime)
        do {
//            try audioFile = AVAudioFile(forReading: url!)
//            engine.connect(audioPlayerNode, to: engine.mainMixerNode, format: nil)
//            audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
//            try engine.start()
//            audioPlayerNode.play()
            
            let audioFile = try AVAudioFile(forReading: url!)
            
            engine.connect(audioPlayerNode!, to: changeAudioUnitTime, format: nil)
            engine.connect(changeAudioUnitTime, to: engine.mainMixerNode, format: nil)
            
            audioPlayerNode?.scheduleFile(audioFile, at: nil, completionHandler: nil)
            changeAudioUnitTime.pitch = value
            
            try engine.start()
            
            audioPlayerNode?.play()
        } catch let error as NSError {
            print("audioFile error: \(error.localizedDescription)")
        }
        
        
        
        //engine.attach(changeAudioUnitTime)
        //engine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil)
        //engine.connect(changeAudioUnitTime, to: engine.outputNode, format: nil)
        
        //changeAudioUnitTime.pitch = 1000
        
//        if (rateOrPitch == "rate") {
//            changeAudioUnitTime.rate = value
//        } else {
//            changeAudioUnitTime.pitch = value
//        }
        
//        engine.prepare()
//        do {
//            try engine.start()
//        } catch {
//            print("error")
//        }
//        
//        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
//
//        audioPlayerNode.play()
//        engine.stop()
//        engine.reset()
    }
    
    @IBAction func stop(_ sender: Any) {
        audioPlayerNode?.stop()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Record Encode Error")
    }

}
