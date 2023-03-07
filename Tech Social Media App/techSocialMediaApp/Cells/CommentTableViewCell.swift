//
//  CommentTableViewCell.swift
//  techSocialMediaApp
//
//  Created by Sterling Jenkins on 2/6/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentBodyLabel: UILabel!
    @IBOutlet weak var commentAuthorLabel: UILabel!
    @IBOutlet weak var commentCreatedDateLebel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCommentContents(with comment: Comment) {
        
        if let body = comment.body, let user = comment.userName, let date = comment.createdDate {
            commentBodyLabel.text = body
            commentAuthorLabel.text = "   - \(user)"
            commentCreatedDateLebel.text = "\(date)"
        }
    }
}
