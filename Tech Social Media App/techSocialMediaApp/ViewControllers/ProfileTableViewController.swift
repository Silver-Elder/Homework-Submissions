//
//  ProfileTableViewController.swift
//  Year Long Project (Part 1)
//
//  Created by Sterling Jenkins on 11/4/22.
//

import UIKit

//
//  ProfileTableViewController.swift
//  Year Long Project (Part 1)
//
//  Created by Sterling Jenkins on 11/4/22.
//

import UIKit

class ProfileTableViewController: UITableViewController, PostTableViewCellDelegate {
    func viewCommentsButtonTapped(sender: PostTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        let post = posts[indexPath.row]
        
        let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "postComments") as! CommentsTableViewController
        
        viewController.post = post
        viewController.unwindTo = "Profile"
        self.navigationController?.present(viewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.cellLayoutMarginsFollowReadableWidth = true //This is the proggramatic way to turn on the "Follow Readable Width", setting for the table view found in the Size Inspector—Layout Margins on the InterfacuBuilder
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250.0
        tableView.sectionHeaderHeight = 50
        
        retrievePosts()
    }

    // MARK: - Table view data source

    var posts: [Post] = []
    
    let networkController = AuthenticationController()
    
    func retrievePosts() {
        Task {
            do {
                let apiRequest = RetrieveUsersPosts()
                
                let profilePosts = try await networkController.apiRequest(for: apiRequest)
                
                posts = profilePosts
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return posts.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Profile Cell", for: indexPath) as! ProfileTableViewCell
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell", for: indexPath) as! PostTableViewCell
                
            cell.postCellDelegate = self
            cell.setPostContents(with: posts[indexPath.row])
            
            return cell
        }

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            return
        default:
            performSegue(withIdentifier: "addOrEditPost", sender: tableView.cellForRow(at: indexPath))
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        switch indexPath.section {
        case 0:
            return .none
        default:
            return .delete
        }
    }
    
    func deletePost(at indexPath: IndexPath) {
        Task {
            do {
               try await networkController.apiDeleteRequest(for: DeleteUserPost(forPost: posts[indexPath.row]))
                posts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletePost(at: indexPath)
        }
    }
    
    @IBAction func createNewPost(_ sender: UIButton) {
        performSegue(withIdentifier: "addOrEditPost", sender: sender)
    }
    
    @IBSegueAction func addOrEditPost(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> NewOrEditPostTableViewController? {
        guard segueIdentifier == "addOrEditPost" else { return nil }
        
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let post = posts[indexPath.row]
            return NewOrEditPostTableViewController(coder: coder, post: post)
        }
        
        return NewOrEditPostTableViewController(coder: coder, post: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toComments" else { return }
    }
    
    func newPostAPICall(forPost post: any APIRequest) {
        Task {
            do {
                try await networkController.apiRequest(for: post)
                retrievePosts()
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func unwindToProfile(segue: UIStoryboardSegue) {
        guard segue.identifier == "savePost", let sourceViewController = segue.source as? NewOrEditPostTableViewController, let newOrEditedPost = sourceViewController.newOrEditedPost else { return }
        
        newPostAPICall(forPost: newOrEditedPost)
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

/*
class ProfileTableViewController: UITableViewController, PostTableViewCellDelegate {
    func viewCommentsButtonTapped(sender: PostTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        let post = posts[indexPath.row - 1]
        
        let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "postComments") as! CommentsTableViewController
        
        viewController.post = post
        viewController.unwindTo = "Profile"
        self.navigationController?.present(viewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.cellLayoutMarginsFollowReadableWidth = true //This is the proggramatic way to turn on the "Follow Readable Width", setting for the table view found in the Size Inspector—Layout Margins on the InterfacuBuilder
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250.0
        
        retrievePosts()
    }

    // MARK: - Table view data source

    var posts: [Post] = []
    
    let networkController = AuthenticationController()
    
    func retrievePosts() {
        Task {
            do {
                let apiRequest = RetrieveUsersPosts()
                
                let profilePosts = try await networkController.apiRequest(for: apiRequest)
                
                posts = profilePosts
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Profile Cell", for: indexPath) as! ProfileTableViewCell
            
            
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell", for: indexPath) as! PostTableViewCell
            
            cell.postCellDelegate = self
            cell.setPostContents(with: posts[indexPath.row - 1])
            
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        
        performSegue(withIdentifier: "addOrEditPost", sender: tableView.cellForRow(at: indexPath))
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func deletePost(at indexPath: IndexPath) {
        Task {
            do {
               try await networkController.apiDeleteRequest(for: DeleteUserPost(forPost: posts[indexPath.row - 1]))
                posts.remove(at: indexPath.row - 1)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletePost(at: indexPath)
        }
    }
    
    @IBAction func createNewPost(_ sender: UIButton) {
        performSegue(withIdentifier: "addOrEditPost", sender: sender)
    }
    
    @IBSegueAction func addOrEditPost(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> NewOrEditPostTableViewController? {
        guard segueIdentifier == "addOrEditPost" else { return nil }
        
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let post = posts[indexPath.row - 1]
            return NewOrEditPostTableViewController(coder: coder, post: post)
        }
        
        return NewOrEditPostTableViewController(coder: coder, post: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toComments" else { return }
    }
    
    func newPostAPICall(forPost post: any APIRequest) {
        Task {
            do {
                try await networkController.apiRequest(for: post)
                retrievePosts()
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func unwindToProfile(segue: UIStoryboardSegue) {
        guard segue.identifier == "savePost", let sourceViewController = segue.source as? NewOrEditPostTableViewController, let newOrEditedPost = sourceViewController.newOrEditedPost else { return }
        
        newPostAPICall(forPost: newOrEditedPost)
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
*/
