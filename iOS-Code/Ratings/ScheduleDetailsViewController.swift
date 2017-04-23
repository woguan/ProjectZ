

import UIKit

class ScheduleDetailsViewController: UITableViewController {
    
  

    
  //  let dateFormatter = NSDateFormatter()
    
    var stringDate:String = "00:00"
    
    @IBAction func timePicker(_ sender: UIDatePicker) {
        
        var dateAMPM:String = ""
        let userDateFormatter = DateFormatter()
        userDateFormatter.dateStyle = .none
        userDateFormatter.timeStyle = .short
        //24 HOUR TIME: userDateFormatter.dateFormat = "HH:mm"

        userDateFormatter.timeZone = TimeZone(secondsFromGMT: -25200)
        dateAMPM = userDateFormatter.string(from: sender.date)
        
        // converting to 24:00 fromat
        
        let dateAsString = dateAMPM
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: dateAsString)
        
        dateFormatter.dateFormat = "HH:mm"
        stringDate = dateFormatter.string(from: date!)
        
       // print(stringDate)
    }
    
    var floatPos:Float = 0.0
    @IBAction func positionPicker(_ sender: UISlider) {
        floatPos = sender.value
    }
    
    
  var schedule:Schedule?
  
  var daysArray:[String] = [String](){
    didSet {
      let stringRep = daysArray.joined(separator: ", ") // "Sunday, Monday, Tuesday"
      detailLabel.text? = stringRep
    }
  }
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var detailLabel: UILabel!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  deinit {

  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      nameTextField.becomeFirstResponder()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SaveScheduleDetail" {

        if(!daysArray.isEmpty){
        schedule = Schedule(time: stringDate, day:daysArray, pos: Int(floatPos))
        }
 
        
    }
  }
  
  //Unwind segue
  @IBAction func unwindWithSelectedGame(_ segue:UIStoryboardSegue) {
    
    if let dayPickerViewController = segue.source as? DayPickerViewController{
        daysArray = dayPickerViewController.selectedDaysArray
    }
    
    
  }
  
}
