//
//  CommentsTableViewController.swift
//  techSocialMediaApp
//
//  Created by Sterling Jenkins on 2/6/23.
//

import UIKit

class CommentsTableViewController: UITableViewController {

    var post: Post?
    var unwindTo: String?
    
    var comments = [Comment]()
    
    let networkController = AuthenticationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveCohortComments()
    
    }

    func retrieveCohortComments() {
        Task {
            do {
                guard let post = post else { throw AuthenticationController.AuthError.couldNotRetrieveInformation }
                let apiRequest = RetrieveComments(forPost: post)
                
                let postComments = try await networkController.apiRequest(for: apiRequest)
                
                comments = postComments
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
        
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return comments.count
       }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "Comment Cell", for: indexPath) as! CommentTableViewCell
           
           cell.setCommentContents(with: comments[indexPath.row])
           
           return cell
           
       }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Segue Actions
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: unwindTo!, sender: nil)
    }
    
    @IBSegueAction func toNewComment(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> NewCommentTableViewController? {
        guard let post = post else { return nil }
        return NewCommentTableViewController(post: post, coder: coder)
    }
    
    func newCommentAPICall(withRequest request: any APIRequest) {
        Task {
            do {
                try await networkController.apiRequest(for: request)
                retrieveCohortComments()
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func unwindToComments(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveComment", let source = segue.source as? NewCommentTableViewController, let request = source.apiRequiest else { return }
        newCommentAPICall(withRequest: request)
    }
    
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
