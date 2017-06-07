//
//  ViewController.swift
//  arduinoWifiTest
//
//  Created by Guan Wong on 5/19/16.
//  Copyright © 2016 Guan Wong. All rights reserved.
//

import UIKit

import Darwin.C
import Firebase
import FirebaseDatabase


//socket
let client:TCPClient = TCPClient(addr: "172.20.10.4", port: 80)

class ViewController: UIViewController {
//var manualViewController:ManualViewController?
    
    
    @IBAction func debugBut(_ sender: UIButton) {
        nextScene(value: .hasConnection)
    }
    @IBAction func wifiBut(_ sender: UIButton) {
        let (success,errmsg)=client.connect(timeout: 1)
            if success{
                print("Successfully connected via WiFi")
                client.connected = true
                //update time of arduino
                //updateArduinoTime()
                nextScene(value: .hasConnection)
            }else{
                print(errmsg)
                nextScene(value: .noConnection)
            }
    }
    
    @IBAction func blueBut(_ sender: UIButton) {
        serial.startScanning()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ViewController.connectTimeOut), userInfo: nil, repeats: false)
        
        // Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updates), userInfo: nil, repeats: false)
        
    }
    
    enum Connection{
        case hasConnection
        case noConnection
    }
    
    func nextScene (value connection:Connection){
        switch(connection){
        case .hasConnection:
            if NewUser {
                self.performSegue(withIdentifier: "newSetUp", sender: nil)
            }
            else{
                self.performSegue(withIdentifier: "mainmenu", sender: nil)
            }
        case .noConnection:
                print("FAILED TO CONNECT TO DEVICE")
        }
    }
    
    func connectTimeOut(){
        serial.stopScanning()
        if serial.isConnected() {
            //update time of arduino
             updateArduinoTime()
            // move to next scene
            self.performSegue(withIdentifier: "newSetUp", sender: nil)
            nextScene(value: .hasConnection)
        }
        else{
            print("Bluetooth failed to connect")
            nextScene(value: .noConnection)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // initialize bluetooth
        serial
        
     //  Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updates), userInfo: nil, repeats: true)
        
        // testing database:
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let ref = FIRDatabase.database().reference(fromURL: "https://projectz-a9967.firebaseio.com/").child("user")
        ref.child(userID!).observe(.value, with: { (snapshot) in
            if let dict = snapshot.value as? [String:AnyObject]{
//                for val in dict{
//                    print (val)
//                }
                currentUserEmail = dict["Email"] as? String
                currentHardwareUUID = dict["MachineUUID"] as? String
            }
            else{
                print("failed with: ", snapshot.value ?? "Failed")
            }
        })
        
    }
    
    func updates() {
        // track the # of nodes in view
        print ("hello")
        
        
    }
    
    func updateArduinoTime(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        // For hh:mm
        let str = dateFormatter.string(from: date)
       // print(str)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let wday = dateFormatter.string(from: date)
        
        let weekday = getDayOfWeek(wday)! - 1
        let msg:String = "SETT \(String(weekday)) \(str)"
      //  let msg:String = "SETT \(String(weekday)) 9:26:00"
        print(msg)
        // command to send
        if(serial.isConnected()){
  
            if let svc = serial.bleService{
           
                svc.sendMessageToDevice(msg)
            }
        }
    }
    
    func getDayOfWeek(_ today:String)->Int? {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let todayDate = formatter.date(from: today) {
            let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
            let myComponents = (myCalendar as NSCalendar).components(.weekday, from: todayDate)
            let weekDay = myComponents.weekday
            return weekDay
        } else {
            return nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToConnectionView(_ segue: UIStoryboardSegue){
        print ("Unwind to connection View.")
    }
    
}

