//
//  PostTableViewCell.swift
//  Year Long Project (Part 1)
//
//  Created by Sterling Jenkins on 11/2/22.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func viewCommentsButtonTapped(sender: PostTableViewCell)
}

class PostTableViewCell: UITableViewCell {

    weak var postCellDelegate: PostTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
   
    
    
    func setPostContents(with post: Post) {
        if let title = post.title, let body = post.bodyText, let user = post.user, let date = post.createdDate, let likes = post.likes, let comments = post.comments {
            titleLabel.text = "~ \(title) ~"
            bodyTextLabel.text = body
            userNameLabel.text = "   - \(user)"
            dateLabel.text = "\(date)"
            likesLabel.text = "Likes: \(likes)"
            commentsLabel.text = "\n Comments: \(comments)\n"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected,    animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func profileViewCommentsButtonTapped(_ sender: UIButton) {
        postCellDelegate?.viewCommentsButtonTapped(sender: self)
    }
    @IBAction func cohortViewCommentsButtonTapped(_ sender: UIButton) {
        postCellDelegate?.viewCommentsButtonTapped(sender: self)
    }
    
}
