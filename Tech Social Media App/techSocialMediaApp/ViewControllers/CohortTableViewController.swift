//
//  CohortTableViewController.swift
//  techSocialMediaApp
//
//  Created by Sterling Jenkins on 2/3/23.
//

import UIKit

class CohortTableViewController: UITableViewController, PostTableViewCellDelegate {
    func viewCommentsButtonTapped(sender: PostTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        let post = posts[indexPath.row]
        
        let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "postComments") as! CommentsTableViewController
        
        viewController.post = post
        viewController.unwindTo = "Cohort"
        self.navigationController?.present(viewController, animated: true)
    }
    var posts = [Post]()
    
    let networkController = AuthenticationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveCohortPosts()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.cellLayoutMarginsFollowReadableWidth = true //This is the proggramatic way to turn on the "Follow Readable Width", setting for the table view found in the Size Inspector—Layout Margins on the InterfacuBuilder
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250.0
        
        retrieveCohortPosts()
        
        
    }

    func retrieveCohortPosts() {
        Task {
            do {
                let apiRequest = RetrievePostsForAllUsers()
                
                let cohortPosts = try await networkController.apiRequest(for: apiRequest)
                
                posts = cohortPosts
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
           return posts.count
       }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell", for: indexPath) as! PostTableViewCell
           
           cell.postCellDelegate = self
           cell.setPostContents(with: posts[indexPath.row])
           
           return cell
           
       }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func unwindToCohortThread(segue: UIStoryboardSegue) {
    }
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
