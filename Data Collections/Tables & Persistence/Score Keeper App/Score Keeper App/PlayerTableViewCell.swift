//
//  PlayerTableViewCell.swift
//  Score Keeper App
//
//  Created by Sterling Jenkins on 11/15/22.
//

import UIKit

protocol PlayerCellDelegate: AnyObject {
    func stepperValueChanged(sender: PlayerTableViewCell, stepperValue: UIStepper)
}

class PlayerTableViewCell: UITableViewCell {

    weak var cellDelegate: PlayerCellDelegate?
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreStepper: UIStepper!
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    @IBAction func playerScoreSteppervalueChanged(_ sender: UIStepper) {
        playerScoreLabel.text = "\(Int(playerScoreStepper.value))"
        cellDelegate?.stepperValueChanged(sender: self, stepperValue: playerScoreStepper)
        }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
