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
    
    @IBOutlet weak var counterclockButton: UIButton!
    
    @IBOutlet weak var clockwiseButton: UIButton!
    
    @IBAction func Counterclock(_ sender: UIButton) {
        print ("counter clockwise pressed")
    }
    @IBAction func Clockwise(_ sender: UIButton) {
        print ("clockwise pressed")
    }
    
    @IBAction func submitSetting(_ sender: UIButton) {
        if (DebugMode){
            let okayButton = UIAlertAction(title: "OK", style: .cancel, handler: {(alert) -> Void in
            
           self.performSegue(withIdentifier: "setupDone", sender: nil)
            
            })
            
            
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
            counterclockButton.isEnabled = false
        case .Counterclockwise:
            clockwiseButton.isEnabled = false
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
