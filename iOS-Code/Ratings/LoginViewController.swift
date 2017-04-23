//
//  LoginViewController.swift
//  ProjZ
//
//  Created by Guan Wong on 2/8/17.
//  Copyright © 2017 Guan Wong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        do{
            try FIRAuth.auth()?.signOut()
            print("User log out")
        }catch let err{
            print (err)
        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    @IBAction func submit(_ sender: UIButton) {
        
        // Firebase login auth
        
        guard let email = emailField.text, let password = passwordField.text else{
            
            print ("Invalid inputs")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print (error)
                return
            }
            
            // Success Connection
            
            // Todo: Move to another scene
            self.performSegue(withIdentifier: "segueVerified", sender: nil)
            
            // Below is an example how to fetch user data:
        /*    let userID = FIRAuth.auth()?.currentUser?.uid
            
            let ref = FIRDatabase.database().reference(fromURL: "https://projectz-a9967.firebaseio.com/").child("user")
            ref.child(userID!).observe(.value, with: { (snapshot) in
                if let dict = snapshot.value as? [String:AnyObject]{
                    for val in dict{
                        print (val)
                    }
                }
                else{
                    print("failed with: ", snapshot.value ?? "Failed")
                }
            })*/
            // Finish sample to fetch data
        
            
            
        })
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
