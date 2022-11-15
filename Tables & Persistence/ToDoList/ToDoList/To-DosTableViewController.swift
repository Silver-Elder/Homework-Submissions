//
//  To-DosTableViewController.swift
//  ToDoList
//
//  Created by Sterling Jenkins on 11/11/22.
//

import UIKit

class To_DosTableViewController: UITableViewController {

    var toDos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
            // ^^^ This is the "proper", way to install an edit button. If you just add a bar button item in the storyboard and set it to "edit", it will look like a regular edit button, but won't funcation like one. This line of code creates an edit button that actually works like an edit button should.
            // (That being said, I still added the bar button item on the storyboard to show in my visul design that an edit button will be there 😜. I just need to remember that the code behind that button is here)
        
        if let savedToDos = ToDo.loadToDos() {
            toDos = savedToDos
        } else {
            toDos = ToDo.loadSampleToDos()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
       
        let toDo = toDos[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = toDo.title
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

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
    
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> NewTo_DoTableViewController? {
        let toDoDetailController = NewTo_DoTableViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return toDoDetailController
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        toDoDetailController?.toDo = toDos[indexPath.row]
        
        return toDoDetailController
    }
    
    
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! NewTo_DoTableViewController
        
        if let toDo = sourceViewController.toDo {
            if let indexOfOrigiionalToDo = toDos.firstIndex(of: toDo) {
                toDos[indexOfOrigiionalToDo] = toDo
                tableView.reloadRows(at: [IndexPath(row: indexOfOrigiionalToDo, section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: toDos.count, section: 0)
                toDos.append(toDo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

}
