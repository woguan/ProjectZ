//
//  ManualViewController.swift
//  Ratings
//
//  Created by Guan Wong on 5/30/16.
//  Copyright © 2016 Ray Wenderlich. All rights reserved.
//

import UIKit

class ManualViewController: UIViewController {

    var amountSlide:Int = 0
    
    @IBAction func CounterClock(_ sender: UIButton) {
        
        let str:String = "COUT \(String(amountSlide))"
        
        sendToArduino(str)
    }
    
    @IBAction func ClockWise(_ sender: UIButton) {
        let str:String = "CLOC \(String(amountSlide))"
        
        sendToArduino(str)
    }
 
    @IBAction func SetMaxCounter(_ sender: UIButton) {
        let str:String = "SMIN"
        
        sendToArduino(str)
    }
    
    @IBAction func SetMaxClockWise(_ sender: UIButton) {
        let str:String = "SMAX"
        
        sendToArduino(str)
    }
    
    @IBAction func DisconnectAction(_ sender: UIButton) {
        if (client.isConnected()){
        client.close()
        }
        
        if (serial.isConnected()){
            serial.disconnect()
        }
        self.performSegue(withIdentifier: "disconnectBack", sender: nil)
    }
    
    
    
    
    @IBAction func sliderValueHasChanged(_ sender: UISlider) {
       // print(sender.value)
        amountSlide = Int(sender.value)
    }
    
    func sendToArduino(_ str:String){
        // bluetooth
        if(serial.isConnected()){
            if let svc = serial.bleService{
                svc.sendMessageToDevice(str)
            }
        }
            // WiFi
        else if(client.isConnected()){
            client.send(str: str)
        }
        else{
            print("MSG NOT SENT: \(str)")
        }
    }
    
    
}
