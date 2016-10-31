/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class GamePickerViewController: UITableViewController {
  
var selectedDay = [Bool](repeating: false, count: 7)
    
  var games:[String] = [
    "Su",
    "Mo",
    "Tu",
    "We",
    "Th",
    "Fr",
    "Sa"]
  
    
 /* var selectedGame:String? {
    didSet {
      if let game = selectedGame {
        selectedGameIndex = games.indexOf(game)!
      }
    }
  }*/
    var selectedGame:String = ""
    
  var selectedGameIndex:Int?
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
    cell.textLabel?.text = games[indexPath.row]
    
    if indexPath.row == selectedGameIndex {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    
//    //Other row is selected - need to deselect it
//    if let index = selectedGameIndex {
//      let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
//      cell?.accessoryType = .None
//    }
    
//    let cell1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: indexPath.row, inSection: 0))
//
//    if cell1?.accessoryType == .None {
//        cell1?.accessoryType = .Checkmark
//    } else if cell1?.accessoryType == .Checkmark{
//        cell1?.accessoryType = .None
//    }
  

    selectedGame = games[indexPath.row]
    
    //update the checkmark for the current row
    let cell = tableView.cellForRow(at: indexPath)
    if cell?.accessoryType != .checkmark {
        selectedDay[indexPath.row] = true
     
        cell?.accessoryType = .checkmark
    }
    else if cell?.accessoryType == .checkmark{
        selectedDay[indexPath.row] = false

        cell?.accessoryType = .none
    }
    
     // print(selectedDay)
    //cell?.accessoryType = .Checkmark
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //print("1")

    
   /* if segue.identifier == "SaveSelectedGame" {
      if let cell = sender as? UITableViewCell {
        let indexPath = tableView.indexPathForCell(cell)
        if let index = indexPath?.row {
          selectedGame = games[index]
        }
      }
    }*/
  
    var strA:[String] = [String]()
    for i in 0...6{
        if(selectedDay[i]){
            strA.append(games[i])
        }
    }
    let stringRep = strA.joined(separator: ", ") // "Sunday, Monday, Tuesday"
    selectedGame = stringRep
   // print(stringRep)

    
   
    
    }
    
    

  
    
}
