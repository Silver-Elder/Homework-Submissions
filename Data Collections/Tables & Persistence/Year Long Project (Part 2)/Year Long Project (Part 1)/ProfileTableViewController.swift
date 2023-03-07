//
//  ProfileTableViewController.swift
//  Year Long Project (Part 1)
//
//  Created by Sterling Jenkins on 11/4/22.
//
import UIKit

class ProfileTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    var posts: [Post] = [
        Post(title: "My first post", bodyText: "Currently on my way to become a mopile app developer, I'm a tech-loving kid who aspired to one day become an Unmanned Aerial Systems (Drone) Engineer.", user: "Sterling Jenkins", comments: ""),
        Post(title: "Where Do I Start?", bodyText: "First things first, I've got to pass this coding class; but I'm a number of projects behind... Which one should I work on first?", user: "Sterling Jenkins", comments: ""),
        Post(title: "Solution", bodyText: "I think I'll finish this project first, and then start at the earliest assigned assignment.", user: "Sterling Jenkins", comments: ""),
        Post(title: "xCode is Buggy...", bodyText: "I found out that my xCode isn't simulating my code like it should. My instructor, Austin, thought that it might be beause I haven't updated my mac with the newest Ventura OS software. I'll have to download that to find out – but before I do that, I'm going to have to red the terms of use for the download 😏.", user: "Sterling Jenkins", comments: ""),
        Post(title: "Ventura Download Ready to Go!", bodyText: "I've read through the terms and am ready to go!!! Now I've just got to download the new software, but I'll wait till I get home to do that.", user: "Sterling Jenkins", comments: ""),
        Post(title: "Next Step", bodyText: "I'll finish this project, then resume where I left off with the \"Home Furniture\" project.", user: "Sterling Jenkins", comments: ""),
        Post(title: "After I Download Ventura", bodyText: "I was having some very unusual errors with my \"Books\" lab, probably because I'm running on an older OS software; so I'll reapproach that project after I download the new Ventura OS and see if I still have the same problems. If I do... well, my instructors and I are going to have quite a fun time trying to figure out what's broken 😜😂.", user: "Sterling Jenkins", comments: ""),
        Post(title: "Phase Three of My Master Homework Plan", bodyText: "Hopefully, after being able to complete this, the Home Furniture, and my Books labs, I'll start on and finish the \'Epmloyee Roster\" lab by the end of tomorrow!", user: "Sterling Jenkins", comments: ""),
        Post(title: "Phase 4", bodyText: "The next gauntlet will be to finish the end of section 1 book guided project \"List\" (starting on p.256), before the end of Wednesday.", user: "Sterling Jenkins", comments: ""),
        Post(title: "Phase 5", bodyText: "At this point in the week, it'll be Thursday, and the \"Score Keeper\" lab due date will have alreay passed. Completing that will be my next priority, and I'll plan on having that complet no later than the end of Friday. Then, it'll be on to the \"Games Tracker\" lab!!! ", user: "Sterling Jenkins", comments: "(Brayden did say that the Games Tracker lab wasn't required, though, so I just need to make sure I do a good job completing the Score Keeper lab.)")
    ]
    
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
            
            cell.setPostContents(with: posts[indexPath.row - 1])
            
            return cell
        }
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
