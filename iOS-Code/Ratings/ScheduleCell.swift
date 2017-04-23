import UIKit

class ScheduleCell: UITableViewCell {
  
  @IBOutlet weak var positionLabel: UILabel!
  @IBOutlet weak var daysLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  
  var schedule: Schedule! {
    didSet {
      let nf = NumberFormatter()
      nf.numberStyle = .none
        var strBuild:String = ""
      strBuild = nf.string(from: NSNumber(value: schedule.pos))!
      strBuild += "%"
      positionLabel.text = strBuild
    
      let stringRep = schedule.day!.joined(separator: ", ")
      daysLabel.text = stringRep
      nameLabel.text = schedule.time
    }
  }
  
  
}
