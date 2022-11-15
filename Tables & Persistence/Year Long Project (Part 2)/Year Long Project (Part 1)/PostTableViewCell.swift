//
//  PostTableViewCell.swift
//  Year Long Project (Part 1)
//
//  Created by Sterling Jenkins on 11/2/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    
    func setPostContents(with post: Post) {
        titleLabel.text = "~ \(post.title) ~"
        bodyTextLabel.text = post.bodyText
        userNameLabel.text = "   - \(post.user)"
        dateLabel.text = "\(post.date)"
        commentsLabel.text = "\n Comments: \(post.comments)\n"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected,    animated: animated)

        // Configure the view for the selected state
    }

}
