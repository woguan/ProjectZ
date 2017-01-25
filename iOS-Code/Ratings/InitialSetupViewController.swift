//
//  InitialSetupViewController.swift
//  ProjZ
//
//  Created by Guan Wong on 1/25/17.
//  Copyright © 2017 Wong Guan. All rights reserved.
//

import UIKit

class InitialSetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       print ("moving to next scene")
        guard let configurationSettingViewController = segue.destination as? ConfigurationViewController else{
            print ("SHOULD NOT REACH HERE")
            fatalError()
        }
        //configurationSettingViewController.num = 2
        print ("prepare calling: ", segue.destination)
        
    }
    @IBAction func counterClock(_ sender: UIButton) {
        
        
        self.performSegue(withIdentifier: "configuration", sender: nil)
    }
    
    @IBAction func clockwise(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "configuration", sender: nil)
    }
    
}
