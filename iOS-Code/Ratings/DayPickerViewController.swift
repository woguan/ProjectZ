
import UIKit

class DayPickerViewController: UITableViewController {
  
var trackDay = [Bool](repeating: false, count: 7)
    
  var days:[String] = ["Su","Mo","Tu","We","Th","Fr","Sa"]
  
  var selectedDaysArray = [String]()
    
  var selectedDayIndex:Int?
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return days.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath)
    cell.textLabel?.text = days[indexPath.row]
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    //update the checkmark for the current row
    let cell = tableView.cellForRow(at: indexPath)
    if cell?.accessoryType != .checkmark {
        trackDay[indexPath.row] = true
     
        cell?.accessoryType = .checkmark
    }
    else if cell?.accessoryType == .checkmark{
        trackDay[indexPath.row] = false

        cell?.accessoryType = .none
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
    for i in 0...6{
        if(trackDay[i]){
            selectedDaysArray.append(days[i])
        }
    }
    
    }
    
    

  
    
}
