//
//  RegistrationViewController.swift
//  ProjZ
//
//  Created by Guan Wong on 2/8/17.
//  Copyright © 2017 Guan Wong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var retypeField: UITextField!
    
    @IBOutlet weak var uuidField: UITextField!
    
    var emailText:String = "" {
        didSet{
        if (!emailText.contains("@")){
            print ("Invalid email")
        }
    }
    }
    
    var passwordText = "" {
        
        didSet{
            if passwordText.characters.count < 3{
                print("Bad Password")
            }
        }
        
    }
    
    var validInput:Bool = false{
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


 
    func isValidInput(email:String?, password pass:String?, repeatPassword repass:String?) -> (Bool, String){
        
   /*     guard let email = email else {
            return (false, "Empty email")
        }
        
        guard let pass = pass else {
            return (false, "Empty password")
        }
        
        guard let repass = repass else {
            return (false, "Empty Retype Password")
        }*/
        
        // Todo: Validate input
        
        return (true, "Success")
    }
    
    @IBAction func submit(_ sender: UIButton) {
        // check for errors
        
//        @IBOutlet weak var emailField: UITextField!
//        
//        @IBOutlet weak var passwordField: UITextField!
//        
//        @IBOutlet weak var retypeField: UITextField!
//        
//        @IBOutlet weak var uuidField: UITextField!

        let isValid:Bool = isValidInput(email: emailField.text, password: passwordField.text, repeatPassword: retypeField.text).0
        
        
        // use Firebase api to register a new input
        
        if (isValid){
            // Todo: send data to register
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user:FIRUser?, err) in
                if err != nil {
                    print (err!)
                    return
                }
                
                // success register user
               print ("User Registered Successfully")
                
                // updating a database for user
                
                guard let user = user else{
                    print("user is nil.")
                    return
                }
                
                let ref = FIRDatabase.database().reference(fromURL: "https://projectz-a9967.firebaseio.com/")
                
                let userRef = ref.child("user").child(user.uid)
                
                let values = ["Email": self.emailField.text!, "MachineUUID": self.uuidField.text!]
                
                userRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if ( err != nil){
                        print ("GOT ERROR: ", err!)
                        return
                    }
                    // Success updating database
                    print ("Database successfully updated")
                    
                    // Move user to initial page
                    self.performSegue(withIdentifier: "segueRegistrationDone", sender: nil)
                    
                })
                
                
            })
        }
    }

}
