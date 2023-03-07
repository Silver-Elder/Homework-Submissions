//
//  NewPostTableViewController.swift
//  techSocialMediaApp
//
//  Created by Sterling Jenkins on 2/7/23.
//

import UIKit

class NewOrEditPostTableViewController: UITableViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var post: Post?
    var newOrEditedPost: (any APIRequest)?
    
    required init?(coder: NSCoder, post: Post?) {
        self.post = post
        self.newOrEditedPost = nil
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let post = post {
            navigationController?.title = "Edit Post"
            titleTextField.text = post.title
            bodyTextField.text = post.bodyText
        }
        
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let title = titleTextField.text ?? ""
        let body = bodyTextField.text ?? ""
        
        saveButton.isEnabled = !title.isEmpty && !body.isEmpty
    }
    
    @IBAction func textFieldEdited(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "savePost", let title = titleTextField.text, let body = bodyTextField.text else { return }
        
        if post == nil {
            newOrEditedPost = CreateUserPost(title: title, body: body)
        } else {
            newOrEditedPost = EditUserPost(postID: (post?.postID)!, title: title, body: body)
        }
    }
    // MARK: - Table view data source

    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
