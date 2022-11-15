//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Sterling Jenkins on 11/15/22.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender: ToDoTableViewCell)
}

class ToDoTableViewCell: UITableViewCell {
    
    weak var delegate: ToDoCellDelegate?

    @IBOutlet weak var toDoIsCompleteButton: UIButton!
    @IBOutlet weak var toDoTitleLabel: UILabel!
    
    @IBAction func toDoIsCompleteButtonTapped(_ sender: Any) {
        delegate?.checkmarkTapped(sender: self)
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
