//
//  NewSettingViewController.swift
//  ProjZ
//
//  Created by Guan Wong on 1/25/17.
//  Copyright © 2017 Wong Guan. All rights reserved.
//

import UIKit

class InitialSettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print ("Sending to arduino: RESET")
        if(serial.isConnected()){
            if let svc = serial.bleService{
                svc.sendMessageToDevice("RESET")
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func unwindToNewSettingViewController(_ segue: UIStoryboardSegue){
     print ("Unwind to first screen.")
        DirectionChoice = .None
        
        // Todo: RESET ALL SMIN/SMAX OF DEVICE ( done )
        if(serial.isConnected()){
            if let svc = serial.bleService{
                svc.sendMessageToDevice("RESET")
            }
        }
        print ("All settings to arduino should be Reset at this point.")
    }
}
