//
//  InitialSetupViewController.swift
//  ProjZ
//
//  Created by Guan Wong on 1/25/17.
//  Copyright © 2017 Wong Guan. All rights reserved.
//

import UIKit

class UserChoiceSetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navi = segue.destination as? UINavigationController else {
            print ("Should not reach here [1]")
            fatalError()
        }
        
        guard let configurationSettingViewController =  navi.viewControllers[0] as? ConfigurationViewController else{
            print ("Should not reach here [2]")
            fatalError()
        }
        
        // set up user choice
        configurationSettingViewController.setUserChoice(option: DirectionChoice)
        
    }
    @IBAction func counterClock(_ sender: UIButton) {
        DirectionChoice = .Counterclockwise
        self.performSegue(withIdentifier: "configuration", sender: nil)
    }
    
    @IBAction func clockwise(_ sender: UIButton) {
        DirectionChoice = .Clockwise
        self.performSegue(withIdentifier: "configuration", sender: nil)
    }
    
}
