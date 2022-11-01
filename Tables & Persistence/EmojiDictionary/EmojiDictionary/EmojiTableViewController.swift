//
//  EmojiTableTableViewController.swift
//  EmojiDictionary
//
//  Created by Sterling Jenkins on 10/18/22.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var emojis: [Emoji] =
            [ Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
            Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
            Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
            Emoji(symbol: "🧑‍💻", name: "Developer", description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software, programming"),
            Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "something slow"),
            Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
            Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
            Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
            Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
            Emoji(symbol: "📚", name: "Stack of Books",description: "Three colored books stacked on each other.", usage: "homework, studying"),
            Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
            Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
            Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
            // ^^^ This is a pre-set feature that allows you to generate the edit button WITHOUT going into storyboard
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.cellLayoutMarginsFollowReadableWidth = true //This is the proggramatic way to turn on the "Follow Readable Width", setting for the table view found in the Size Inspector—Layout Margins on the InterfacuBuilder
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        emojis = Emoji.loadFromFile()
        if emojis.isEmpty {
            emojis = Emoji.sampleEmojis
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData() //You'll use this function in the case that, say, your user goes into a cell, changes the data for that cell (and thereby updates the dataset your main table is based on), and then returns to the main table. If you don't run this function when the user return to the main table, the main table will appear the same since the table is still displaying the old instance of the data, and hasn't been ordered to display the updated instance of the data
    }
    // MARK: - Table view data source
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    */
        // ^^^ This function is OPTIONAL, and the system will default the number of sections to 1 when the funcation is not present
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //NOTE: IndexPath IS NOT the same as an array index. It referrs to the Table itself — specifically the number of the section and row being referenced (e.x. section 0, row 3 (which corresponds to section 1, row 4)). ALSO NOTE: Your row and cell are — visually speaking — the EXACT SAME THING. The difference in the names of "row" and "cell" is only the type of the code associated with that name. Your "row", is an int type, and denotes the order of the row/cell in your list of cells. Your "cell", is a UITableViewCell type, and decribes the rendered content of your cell/row.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell // this last part of "as! EmojiTableViewCell" force casts the "UITableViewCell" that this function returns to be OUR specific EmojiTableViewCell type.
        
        let emoji = emojis[indexPath.row]

        /*
            //This was code for configuring our cells BEFORE we created our custom cell and corresponding custon cell code
        var content = cell.defaultContentConfiguration()
        content.text = "\(emoji.symbol) - \(emoji.name)"
        content.secondaryText = emoji.description
//        content.text = "\(indexPath.row)"
        
        cell.contentConfiguration = content
         */
        
        cell.update(with: emoji) // This func is found in the "EmojiTableViewCell" file
        
        cell.showsReorderControl = true // This DOES NOT make the reorder triple-lines on the right-hand side of your rows/cells appear. Apple wrote some bacgroun code that says that the reorder triple-line icon WILL NOT appear unless BOTH "cell.showsReorderControl = true", AND the edit feature is SET BY THE USER to on.

        return cell
    }
    
    /*
        // vvv This code will be handled by our "AddEditEmojiTableViewController" initializer.
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emoji = emojis[indexPath.row]
        print("\(emoji.symbol) - \(indexPath)")
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        // This removes the "delete" icon on the left-hand side when editing move is enabled
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
        
    }

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
    
    
    @IBSegueAction func segueToAddEditEmojiTableView(_ coder: NSCoder, sender: Any?) -> AddEditEmojiTableViewController? {
        if let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
                // Editing Emoji
                let emojiToEdit = emojis[indexPath.row]
                return AddEditEmojiTableViewController(coder: coder,
                   emoji: emojiToEdit)
            } else {
                // Adding Emoji
                return AddEditEmojiTableViewController(coder: coder,
                   emoji: nil)
            }
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
            let sourceViewController = segue.source
               as? AddEditEmojiTableViewController,
            let emoji = sourceViewController.emoji else { return }
    
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        Emoji.saveToFile(emojis: emojis)
    }
}
