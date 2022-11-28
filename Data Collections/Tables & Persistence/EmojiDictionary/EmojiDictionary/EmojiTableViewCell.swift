//
//  EmojiTableViewCell.swift
//  EmojiDictionary
//
//  Created by Sterling Jenkins on 10/19/22.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    override func awakeFromNib() { // Think of this as being like a "viewDidLoad" for TableViews.
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func update(with emoji: Emoji) {
        emojiLabel.text = emoji.symbol
        nameLabel.text = emoji.name
        descriptionLabel.text = emoji.description
    }
    
}
