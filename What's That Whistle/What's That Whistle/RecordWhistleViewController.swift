//
//  RecordWhistleViewController.swift
//  What's That Whistle
//
//  Created by Yohannes Wijaya on 11/7/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import AVFoundation

class RecordWhistleViewController: UIViewController, AVAudioRecorderDelegate {
    
    // MARK: - Stored Properties
    
    var stackView: UIStackView!
    var recordButton: UIButton!
    
    var failLabel: UILabel!
    
    var recordingSession: AVAudioSession!
    var whistleRecorder: AVAudioRecorder!
    
    // MARK: - Class Methods
    
    class func getDocumentsDirectory() -> NSString? {
        let searchPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        guard let documentDirectory = searchPaths.first else { return nil }
        return documentDirectory
    }
    
    class func getWhistleURL() -> NSURL {
        let audioFileName = RecordWhistleViewController.getDocumentsDirectory()!.stringByAppendingPathComponent("whistle.m4a")
        let audioUrl = NSURL(fileURLWithPath: audioFileName)
        return audioUrl
    }
    
    // MARK: - Methods Override

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Record your whistle"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Record", style: .Plain, target: nil, action: nil)
        
        self.recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try self.recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try self.recordingSession.setActive(true)
            self.recordingSession.requestRecordPermission({ [unowned self] (allowed: Bool) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if allowed { self.loadRecordingUI() }
                    else { self.loadFailUI() }
                })
            })
        }
        catch { self.loadFailUI() }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor.grayColor()
        self.stackView = UIStackView()
        self.stackView.spacing = 30
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.distribution = UIStackViewDistribution.FillEqually
        self.stackView.alignment = UIStackViewAlignment.Center
        self.stackView.axis = UILayoutConstraintAxis.Vertical
        self.view.addSubview(self.stackView)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[stackView]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["stackView": self.stackView]))
        self.view.addConstraint(NSLayoutConstraint(item: self.stackView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
    }
    
    // MARK: - Delegate Methods
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag { self.finishRecording(success: false) }
    }
    
    // MARK: - Local Methods
    
    func finishRecording(success success: Bool) {
        self.view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        
        self.whistleRecorder.stop()
        self.whistleRecorder = nil
        
        if success {
            self.recordButton.setTitle("Tap to Re-record", forState: .Normal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "nextTapped")
        }
        else {
            self.recordButton.setTitle("Tap to Record", forState: UIControlState.Normal)
            
            let alertController = UIAlertController(title: "Record failed", message: "There was a problem recording your whistle", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(alertAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func loadRecordingUI() {
        self.recordButton = UIButton()
        self.recordButton.translatesAutoresizingMaskIntoConstraints = false
        self.recordButton.setTitle("Tap to Record", forState: UIControlState.Normal)
        self.recordButton.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        self.recordButton.addTarget(self, action: "recordTapped", forControlEvents: UIControlEvents.TouchUpInside)

        self.stackView.addArrangedSubview(self.recordButton)
    }
    
    func loadFailUI() {
        self.failLabel = UILabel()
        self.failLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.failLabel.text = "Recording failed: please ensure the app has access to your microphone."
        self.failLabel.numberOfLines = 0

        self.stackView.addArrangedSubview(self.failLabel)
    }
    
    func startRecording() {
        // 1. Make the view have a red bg so user knows when it's recording.
        self.view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        
        // 2. Change the title of the record button.
        self.recordButton.setTitle("Tap to Stop", forState: UIControlState.Normal)
        
        // 3. Save the whistle
        let audioURL = RecordWhistleViewController.getWhistleURL()
        print(audioURL.absoluteString)
        
        // 4. Create a dict to describe the format, sample rate, channels, & quality
        let audioSettings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        // 5. Create AVAudioRecorder object pointing @ our whistle url, set ourselves as the delegate, then call its record() method
        do {
            self.whistleRecorder = try AVAudioRecorder(URL: audioURL, settings: audioSettings)
            self.whistleRecorder.delegate = self
            self.whistleRecorder.record()
        }
        catch { self.finishRecording(success: false) }
    }
    
    func recordTapped() {
        if self.whistleRecorder == nil {
            self.startRecording()
        }
        else {
            self.finishRecording(success: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
