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

class PlayerDetailsViewController: UITableViewController {
    
  

    
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
        
        print(stringDate)
    }
    
    var floatPos:Float = 0.0
    @IBAction func positionPicker(_ sender: UISlider) {
        floatPos = sender.value
    }
    
    
  var player:Player?
  
  var game:String = "" {
    didSet {
      detailLabel.text? = game
    }
  }
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var detailLabel: UILabel!
  
  required init?(coder aDecoder: NSCoder) {
   // print("init PlayerDetailsViewController")
    super.init(coder: aDecoder)
  }
  
  deinit {
   // print("deinit PlayerDetailsViewController")
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      nameTextField.becomeFirstResponder()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SavePlayerDetail" {
      //  print("a")
                
//        strBuild = stringDate!.appendContentsOf(floatPos.description)
//        print(strBuild)
        //strBuild = striBuild.appead(floatPos.description)
          //player = Player(name: nameTextField.text, game:game)
        
        
  /*THINGS TO ADD:
         // IF GOOD DATA... DO SOMETHING
         // IF NOT GOOD DATA... DONT DO ANYTHING
         
         */
        
        // good one
        if(game != ""){
        player = Player(name: stringDate, game:game, pos: Int(floatPos))
        }
 
    }
    if segue.identifier == "PickGame"{
      if let gamePickerViewController = segue.destination as? GamePickerViewController {
        gamePickerViewController.selectedGame = game
      }
    }
  }
  
  //Unwind segue
  @IBAction func unwindWithSelectedGame(_ segue:UIStoryboardSegue) {
  //  print("2")
   /* if let gamePickerViewController = segue.sourceViewController as? GamePickerViewController,
      selectedGame = gamePickerViewController.selectedGame {
        game = selectedGame
    
    }*/
    
    if let gamePickerViewController = segue.source as? GamePickerViewController{
        game = gamePickerViewController.selectedGame
    }
    
    
  }
  
}
