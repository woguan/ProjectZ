import UIKit
import Firebase
import FirebaseDatabase

class SchedulesViewController: UITableViewController {
  
  var schedules:[Schedule] = schedulesData
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return schedules.count
  }
  
    @IBAction func Sync(_ sender: UIButton) {
        
        let alert:UIAlertController
        let okayButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        var isSent:Bool = true
        
        //client.send(str: message)
        var str:String = ""
        var alldates:String = ""
        
        // print schedules
        print ("this is schedules: ", schedules)
        
        for everyData in schedules{
         alldates = "" // small parser for Arduino
            
            if (everyData.day?.contains("Su"))!{
                alldates = appendHelper(alldates, str2: "0")
            }
            if (everyData.day?.contains("Mo"))!{
                alldates = appendHelper(alldates, str2: "1")
            }
            if (everyData.day?.contains("Tu"))!{
                alldates = appendHelper(alldates, str2: "2")
            }
            if (everyData.day?.contains("We"))!{
                alldates = appendHelper(alldates, str2: "3")
            }
            if (everyData.day?.contains("Th"))!{
                alldates = appendHelper(alldates, str2: "4")
            }
            if (everyData.day?.contains("Fr"))!{
                alldates = appendHelper(alldates, str2: "5")
            }
            if (everyData.day?.contains("Sa"))!{
                alldates = appendHelper(alldates, str2: "6")
            }
            
            str = "SCHED \(alldates) \(everyData.time!) \(String(Int(everyData.pos)))"
            print(str) // sample output: SCHED 3456 09:00 36

            // send wifi
            if(serial.isConnected()){
                if let bleService = serial.bleService {
                    bleService.sendMessageToDevice(str)
                    
                }
            }
            else if(client.isConnected()){
        client.send(str: str)
            }
            else{
                isSent = false
                print("To Send: \(str)")
            }
        }
    
        var title:String?
        if(isSent){
      title = "Success"
        }
        else{
            title = "Failed"
        }
        
        // Later, the function below will be called if 'success' only.
        updateScheduleFB()
        
      alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(okayButton)
        present(alert, animated: true, completion: nil)

        
    }
    
    func appendHelper(_ str1:String, str2:String) -> String{
    return str1 + str2
    }
    
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
    
      let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath)
        as! ScheduleCell
      let schedule = schedules[indexPath.row] as Schedule
      cell.schedule = schedule
      return cell
  }
  
    
    // Call this method after successfully sending schedule to Arduino
    func updateScheduleFB(){
        print("Sending to FB: ", schedules)
        
        
        guard let userID = FIRAuth.auth()?.currentUser?.uid else{
            print ("userID empty")
            return
        }
        
        let database = FIRDatabase.database().reference(fromURL: "https://projectz-a9967.firebaseio.com/")
        
        let ref = database.child("user").child(userID).child("schedule")
        
        // Remove all data of the schedule
        ref.removeValue()
        
        // Replace with new data
        for (index, sched) in schedules.enumerated(){
            let values:[String:Any] = ["time": sched.time!, "day":sched.day!, "pos":sched.pos]
            let cref = ref.child("\(index)")
            cref.updateChildValues(values) { (error, fireRef) in
                if let err = error {
                    print (err)
                    return
                }
                
            // Success updated
            }
            
        }
        
       
        
    }
    
  // Mark Unwind Segues
    
    @IBAction func cancelToSchedulesViewController(_ segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveScheduleDetail(_ segue:UIStoryboardSegue) {
        
        if let scheduleDetailsViewController = segue.source as? ScheduleDetailsViewController {
            
            //add the new schedule to the schedules array
            if let schedule = scheduleDetailsViewController.schedule {
                schedules.append(schedule)
               let indexPath = IndexPath(row: schedules.count-1, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
         
        }
    }
}
