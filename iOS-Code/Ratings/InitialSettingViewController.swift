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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func unwindToNewSettingViewController(_ segue: UIStoryboardSegue){
     print ("unwinded")
        
        
        DirectionChoice = .None
        
        // Todo: RESET ALL SMIN/SMAX OF DEVICE 
    }
}
