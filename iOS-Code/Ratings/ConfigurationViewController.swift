//
//  ConfigurationViewController.swift
//  ProjZ
//
//  Created by Guan Wong on 1/25/17.
//  Copyright © 2017 Guan Wong. All rights reserved.
//

import UIKit




class ConfigurationViewController: UIViewController {
    var option:Choice!
    
    var amountSlide:Int = 50
    
    @IBOutlet weak var counterclockButton: UIButton!
    
    @IBOutlet weak var clockwiseButton: UIButton!
    
    
    func sendToArduino(message m:String){
        print("Sending to arduino: ", m)
            if(serial.isConnected()){
                if let svc = serial.bleService{
                    svc.sendMessageToDevice(m)
                }
            }
    }
    
   // func moveBlind(amout)
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        amountSlide = Int(sender.value)
    }
    
    @IBAction func Counterclock(_ sender: UIButton) {
        print ("Counter Clockwise trigged. Rotating Value: \(amountSlide)")
        // Todo: Ask arduino to rotate -- done
        sendToArduino(message: "COUT \(amountSlide)")
    }
    @IBAction func Clockwise(_ sender: UIButton) {
        print ("Clockwise Trigger. Rotating Value: \(amountSlide)")
        // Todo: Ask Arduino to rotate -- done
        sendToArduino(message: "CLOC \(amountSlide)")
    }
    
    @IBAction func submitSetting(_ sender: UIButton) {
        if (DebugMode){
            let okayButton = UIAlertAction(title: "OK", style: .cancel, handler: {(alert) -> Void in
            
           self.performSegue(withIdentifier: "setupDone", sender: nil)
            
            })
            
             print ("At this point... Arduino is fully set up.")
            // Todo: Update Arduino maximum rotation ( the one that is left out ) -- done
           
            guard let op = option else{
                print("Something went wrong")
                return
            }
            
            switch op{
            case .Clockwise:
                sendToArduino(message: "SMAX")
            case .Counterclockwise:
                sendToArduino(message: "SMIN")
            case .None:
                print("Should not reach this statement")
                fatalError()
            }
            
            let alert = UIAlertController(title: "Notice", message: "This is debug mode... All Data passed successfully", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(okayButton)
            present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    func setUserChoice(option:Choice){
        self.option = option
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let option = self.option else {
            return
        }
        switch option {
        case .Clockwise:
            print("User choice: Clockwise... CounterClockwise Button is disabled")
            counterclockButton.isEnabled = false
            // Todo: Update arduino maximum CounterClockwise -- done
            sendToArduino(message: "SMIN")
            print("At this point, Arduino will know the maximum CounterClockwise")
        case .Counterclockwise:
            print("User choice: CounterClockwise... Clockwise Button is disabled")
            clockwiseButton.isEnabled = false
            // Todo: Update arduino maximum CounterClockwise -- done
            sendToArduino(message: "SMAX")
            print("At this point, Arduino will know the maximum Clockwise")
        case .None:
            print ("should not reach here")
            fatalError()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
