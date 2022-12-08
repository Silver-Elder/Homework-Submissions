//
//  RepTableViewCell.swift
//  API Project
//
//  Created by Sterling Jenkins on 12/6/22.
//

import UIKit

class RepTableViewCell: UITableViewCell {

    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var partyStateLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
